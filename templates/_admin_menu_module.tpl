{% if m.acl.is_admin %}
<li><a href="{% url admin_code %}" {% ifequal selected "code" %}class="current"{% endifequal %}>{_ Code _}</a></li>
{% endif %}
