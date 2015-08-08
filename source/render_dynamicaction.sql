/*-------------------------------------
 * Pace JS Functions
 * Version: 1.0 (05.08.2015)
 * Author:  Daniel Hochleitner
 *-------------------------------------
*/
FUNCTION render_pace(p_dynamic_action IN apex_plugin.t_dynamic_action,
                     p_plugin         IN apex_plugin.t_plugin)
  RETURN apex_plugin.t_dynamic_action_render_result IS
  --
  l_theme  VARCHAR2(500) := p_dynamic_action.attribute_01;
  l_color  VARCHAR2(100) := p_dynamic_action.attribute_02;
  l_result apex_plugin.t_dynamic_action_render_result;
  --
BEGIN
  -- Debug
  IF apex_application.g_debug THEN
    apex_plugin_util.debug_dynamic_action(p_plugin         => p_plugin,
                                          p_dynamic_action => p_dynamic_action);
  END IF;
  -- Pace CSS (Color + Theme)
  apex_css.add_file(p_name      => l_theme,
                    p_directory => p_plugin.file_prefix || 'themes/' ||
                                   l_color || '/');

  --
  -- Pace JS
  apex_javascript.add_library(p_name           => 'pace.min',
                              p_directory      => p_plugin.file_prefix,
                              p_version        => NULL,
                              p_skip_extension => FALSE);
  -- Add JS Imline Code
  apex_javascript.add_inline_code(p_code => 'paceOptions = {elements: false,restartOnPushState: false,restartOnRequestAfter: false}');
  --
  l_result.javascript_function := 'function(){null}';
  l_result.attribute_01        := l_theme;
  l_result.attribute_02        := l_color;
  --
  RETURN l_result;
  --
END render_pace;