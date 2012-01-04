{% extends "admin_base.tpl" %}

{% block title %}{_ Code Manager _}{% endblock %}

{% block content %}
	<div id="content" class="zp-85">
		<div class="block clearfix">
                      <h2>{_ Code Manager _}</h2>
                      <div class="item-wrapper">
                          <h3 class="above-item clearfix do_blockminifier { minifiedOnInit: false }">
                              <span class="title">{_ Edit File _}</span>
                              <span class="arrow">{_ make smaller _}</span>
                          </h3>
                          <div class="item">


                             <fieldset class="admin-form">
                                 <div class="notification notice">
                                     {_ Here you can edit an existing file or create a new one.  _}
                                 </div>
                             	<div class="form-item clearfix">
                             		<label for="field-file-name">{_ File Name _}</label>
                                             <input type="text" name="filename" id="filename" style="float: left;" />
                             	</div>
                             	<div class="form-item clearfix">
                                             {% validate id="filename" type={format pattern="^[a-z_]+([a-z0-9-]+.)+(?:[A-Z]{2}|tpl|css|js)$"failure_message="Type a valid filename which ends in .tpl, .css or .js"}  %}
                                             <button id="new-file" onclick="window.location='/admin/code/'+$('#filename').val();" >{_ Create/Edit File _}</button>
                             	</div>
                             </fieldset>
                         </div>
                     </div>
		    <hr class="clear" />
		    <h3 class="above-list ">{_ File overview _}</h3>
		    <ul class="short-list">
		    	<li class="headers clearfix">
                                    <span class="zp-20">{_ Type _}</span>
		    		<span class="zp-60">{_ Name _}</span>
		    
		    	</li>
		    {% for file in files %}
                        <li class="clearfix">
                            <a href="/admin/code/{{file}}"><span class="zp-20"><b>{{file|file_type|default:"Unknown"}}</b></span>
                            <span class="zp-60">{{file}}</span></a>
                            <span class="button-area">
		            				{% if file %}
		            					{% button text=_"Edit File" 
		            							action={redirect location="/admin/code/"|append:file} %}
		            				{% else %}
		            					{% button text=_"View File"
		            							action={redirect location="/"} %}
		            				{% endif %}
                            </span>
		    
                        </li>
		    {% empty %}
		    	<li>{_ No code files found _}</li>
		    {% endfor %}
		    </ul>

		</div>
	</div>
{% endblock %}
