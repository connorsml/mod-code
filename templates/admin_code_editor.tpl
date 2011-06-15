{% extends "admin_base.tpl" %}

{% block title %}{_ Code _}{% endblock %}

{% block content %}
	<div id="content" class="zp-85">
		<div class="block clearfix">

		<h2>{_ Edit _} {{file_name}}</h2>
			<div id="editor" style="position: relative; width: 800px; height: 400px;">{{content|escape}}</div>
                        <script src="/lib/ace/src/ace.js" type="text/javascript" charset="utf-8"></script>
                        <script src="/lib/ace/src/theme-clouds.js" type="text/javascript" charset="utf-8"></script>
                        <script src="/lib/ace/src/mode-javascript.js" type="text/javascript" charset="utf-8"></script>
                        <script src="/lib/ace/src/mode-html.js" type="text/javascript" charset="utf-8"></script>
                        <script src="/lib/ace/src/mode-css.js" type="text/javascript" charset="utf-8"></script>
                        <script>
                        window.onload = function() {
                            var editor = ace.edit("editor");
                            editor.setTheme("ace/theme/clouds");
                            
                            var MyMode = require("ace/mode/{{type|default:"html"}}").Mode;
                            editor.getSession().setMode(new MyMode());    
                        };
                        </script>
		</div>
	</div>
{% endblock %}
