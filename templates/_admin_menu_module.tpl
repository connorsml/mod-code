{% if m.acl.is_admin %}
<li><a href="{% url admin_code %}" {% if admin_code_active %}class="current"{% endif %}>{_ Code Manager _}</a></li>
{% endif %}
