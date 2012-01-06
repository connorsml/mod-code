{% tabs id=#tabs %}
<div id="{{ #tabs }}">
    <ul class="clearfix">
        <li><a href="#{{ #tab }}-upload">{_ Upload _}</a></li>
    </ul>
    <div id="{{ #tab }}-upload">
    <p>{_ Upload a file from your computer. _}</p>
    {% wire id=#form type="submit" postback={static_upload} delegate=delegate %}
        <form id="{{ #form }}" method="POST" action="postback">
            <div class="new-media-wrapper">
                {% if not id %}
                    <div class="form-item clearfix">
                        <label for="new_media_title" style="color:white">{_ Name on Server _}</label>
                        <input type="text" id="file_name" name="file_name" value="{{ file_name|escape }}" />
                        {% validate id="file_name" type={presence} %}
                    </div>
                {% endif %}
                <div class="form-item clearfix">
                    <label for="upload_file">{_ Media file _}</label>
                    <input type="file" id="upload_file" name="upload_file" />
                    {% validate id="upload_file" type={presence} %}
                </div>
                <div class="form-item clearfix">
                    <button type="submit">{_ Upload file _}</button>
                    {% button action={dialog_close} text="Cancel" %}
                </div>
            </div>
        </form>
    </div>
</div>
