{ config, ... }:

# On-call modes for Claude Code, loaded per session with `claude --settings <file>`
# (see the <leader>cr / <leader>cw keymaps in go2one's nvim/lua/plugins/ai.lua).
#
# - oncall-ro.json: read-only. kubectl only sees OrbStack + akdev's view@ contexts,
#   and tools that write to PagerDuty, SigNoz, Sentry, the stage platform or the
#   cluster are denied. Deny rules from --settings can't be lifted by other settings.
# - oncall-rw.json: adds akdev's edit@ contexts and asks before every write.
#
# The akdev kubeconfigs come from:
#   akdev kubeconfig init --roles=view,edit --split-kubeconfigs
let
  home = config.home.homeDirectory;
  orbstack = "${home}/.orbstack/k8s/config.yml";
  viewKubeconfig = "${home}/.kube/config-view";
  editKubeconfig = "${home}/.kube/config-edit";

  kubectlWrites = map (verb: "Bash(kubectl ${verb}:*)") [
    "apply"
    "create"
    "replace"
    "patch"
    "edit"
    "delete"
    "scale"
    "autoscale"
    "rollout"
    "set"
    "label"
    "annotate"
    "taint"
    "cordon"
    "uncordon"
    "drain"
    "exec"
    "cp"
  ];

  pagerdutyWrites = map (t: "mcp__claude_ai_PagerDuty__${t}") [
    "manage_incidents"
    "manage_schedules"
    "manage_services"
    "manage_teams"
    "manage_status_pages"
    "manage_event_orchestrations"
  ];

  stagePlatformWrites = map (t: "mcp__plugin_hm_akuity-stage-mcp__${t}") [
    "apply_argocd_instance"
    "apply_kargo_instance"
    "delete_argocd_instance"
    "delete_argocd_instance_cluster"
    "delete_kargo_instance"
    "delete_kargo_instance_agent"
    "set_agent_tool_approval"
  ];

  signozWrites = map (t: "mcp__claude_ai_Signoz_Cloud_US__signoz_${t}") [
    "create_alert"
    "update_alert"
    "delete_alert"
    "create_dashboard"
    "update_dashboard"
    "patch_dashboard"
    "import_dashboard"
    "delete_dashboard"
    "create_notification_channel"
    "update_notification_channel"
    "delete_notification_channel"
    "create_view"
    "update_view"
    "delete_view"
  ];

  sentryWrites = map (t: "mcp__claude_ai_Sentry__${t}") [
    "update_issue"
    "add_issue_note"
    "link_issue"
    "unlink_issue"
    "create_alert_rule"
    "update_alert_rule"
    "delete_alert_rule"
    "create_metric_monitor"
    "update_metric_monitor"
    "delete_metric_monitor"
    "create_uptime_monitor"
    "update_uptime_monitor"
    "delete_uptime_monitor"
    "create_monitor"
    "delete_monitor_environment"
  ];
in
{
  home.file.".claude/oncall-ro.json".text = builtins.toJSON {
    env.KUBECONFIG = "${orbstack}:${viewKubeconfig}";
    permissions.deny = kubectlWrites ++ pagerdutyWrites ++ stagePlatformWrites ++ signozWrites ++ sentryWrites;
  };

  home.file.".claude/oncall-rw.json".text = builtins.toJSON {
    env.KUBECONFIG = "${orbstack}:${viewKubeconfig}:${editKubeconfig}";
    permissions = {
      defaultMode = "default";
      ask = kubectlWrites ++ pagerdutyWrites ++ stagePlatformWrites ++ signozWrites ++ sentryWrites;
    };
  };
}
