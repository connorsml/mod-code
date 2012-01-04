{% if m.acl.use.mod_code %}
<li><a href="{% url admin_code %}" {% if admin_code_active %}class="current"{% endif %}>{_ Code Manager _}</a></li>
{% endif %}
