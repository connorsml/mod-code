%% @author Michael Connors <michael@bring42.net>
%% @copyright 2012 Michael Connors
%% @doc Action to upload a file to one of the static directories

%% Copyright 2012 Michael Connors
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%% 
%%     http://www.apache.org/licenses/LICENSE-2.0
%% 
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.
-module(action_code_dialog_static_upload).
-author("Michael Connors <michael@bring42.net>").

%% interface functions
-export([
    render_action/4,
    event/2
]).

-include("zotonic.hrl").

render_action(TriggerId, TargetId, _Args, Context) ->
    Postback = {static_upload_dialog},
	{PostbackMsgJS, _PickledPostback} = z_render:make_postback(Postback, click, TriggerId, TargetId, ?MODULE, Context),
	{PostbackMsgJS, Context}.

event({postback, {static_upload_dialog}, _TriggerId, _TargetId}, Context) ->
    Vars = [
        {delegate, atom_to_list(?MODULE)}
    ],
    z_render:dialog("Upload a Static File", "_action_dialog_static_upload.tpl", Vars, Context);

event({submit, {static_upload, _EventProps}, _TriggerId, _TargetId}, Context) ->
    Host = Context#context.host,
    File = z_context:get_q_validated("upload_file", Context),
    FileName = z_context:get_q_validated("file_name", Context),
    ContextUpload = case File of
                        #upload{filename=OriginalFilename, tmpfile=TmpFile} ->
                            Extension = filename:extension(OriginalFilename),
                            To = filename:join([z_utils:lib_dir(priv), "sites", Host, "lib", "images", FileName++Extension]),
                            case z_acl:is_allowed(use, mod_code, Context) of
                                true ->
                                    case lists:member(Extension, [".png", ".gif", ".jpg", ".jpeg", ".tpl", ".css", ".js"]) of
                                        true -> 
                                            file:copy(TmpFile, To),
                                            z_render:growl("File Uploaded!", Context);
                                        false ->
                                            z_render:growl_error("You don't have permission to upload that file type!", Context)
                                    end;
                                false ->
                                    z_render:growl_error("You don't have permission to do that!", Context)
                            end;
                        _ ->
                            z_render:growl("No file specified.", Context)
                    end,
    %% Close the dialog and optionally perform the post upload actions
    z_render:wire({dialog_close, []}, ContextUpload).


