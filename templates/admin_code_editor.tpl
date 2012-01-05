{% extends "admin_base.tpl" %}

{% block title %}{_ Code _}{% endblock %}

{% block content %}
	<div id="content" class="zp-85">
		<div class="block clearfix">
                    
                    <h2>{_ Edit _} {{file_name}}</h2>
                    <div class="item">
                        <h3 class="above-item clearfix do_blockminifier { minifiedOnInit: false }">
                            <span class="title">{_ Edit File _}</span>
                        </h3>
                        <div class="item">
			<div id="my_editor" style="position: relative; width: 100%; height: 400px;">{{content|escape}}</div>
                        <script src="/lib/ace/src/ace.js" type="text/javascript" charset="utf-8"></script>
                        <script src="/lib/ace/src/theme-clouds.js" type="text/javascript" charset="utf-8"></script>
                        <script src="/lib/ace/src/mode-javascript.js" type="text/javascript" charset="utf-8"></script>
                        <script src="/lib/ace/src/mode-html.js" type="text/javascript" charset="utf-8"></script>
                        <script src="/lib/ace/src/mode-zotonic.js" type="text/javascript" charset="utf-8"></script>
                        <script src="/lib/ace/src/mode-css.js" type="text/javascript" charset="utf-8"></script>
                        <script>
                        window.onload = function() {
                            editor = ace.edit("my_editor");
                            editor.setTheme("ace/theme/clouds");
                            
                            var MyMode = require("ace/mode/{{type|default:"html"}}").Mode;
                            editor.getSession().setMode(new MyMode());
                        };
                        </script>
                    </div>
                    <div class="item">
                        {% wire id="save-form" type="submit" postback={save_file filename=file_name} delegate="mod_code" %}
                        <form name="save-form" id="save-form" method="post" action="postback">
                            <input type="hidden" name="code" id="code" value="" />
                            <button type="submit" onclick="$('#code').val(editor.getSession().getValue());" class="zp-10">{_ Save _}</button>
                        </form>
                        {#{% wire id="save-form-close" type="submit" postback={save_file filename=file_name } action={redirect dispatch="admin_code"} delegate="mod_code" %}
                        <form name="save-form-close" id="save-form-close" method="post" action="postback">
                            <input type="hidden" name="code1" id="code1" value="" />
                            <button type="submit" onclick="$('#code1').val(editor.getSession().getValue());" class="zp-10">{_ Save & Close _}</button>
                        </form>#}
		        {% button text=_"Go Back" action={confirm text="Are you sure you want to leave this page? " action={redirect dispatch="admin_code"}} %}
                    </div>
		</div>

	</div>

{% endblock %}
