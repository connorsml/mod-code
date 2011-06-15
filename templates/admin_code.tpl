{% extends "admin_base.tpl" %}

{% block title %}{_ Code _}{% endblock %}

{% block content %}
	<div id="content" class="zp-85">
		<div class="block clearfix">

		<h2>{_ Files _}</h2>
                <input type="text" name="filename" id="filename" style="float: left;" />
                <button id="new-file" onclick="window.location='/admin/code/'+$('#filename').val();" >Edit File</button>
		<hr class="clear" />
		<h3 class="above-list ">{_ File overview _}</h3>
		<ul class="short-list">
			<li class="headers clearfix">
				<span class="zp-20">{_ Name _}</span>
			</li>
		{% for file in files %}
                    <li><a href="/admin/code/{{file}}">{{file}}</a>&nbsp;<button style="float: right;">Edit</button></li>
		{% empty %}
			<li>{_ No code files found _}</li>
		{% endfor %}
		</ul>

		</div>
	</div>
{% endblock %}
