%% @author Michael Connors <michael@bring42.net>
%% @copyright 2011 Michael Connors
%% @doc Overview of templates, scripts and css files

%% Copyright 2011 Michael Connors
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

-module(resource_admin_code_editor).
-author("Michael Connors <michael@bring42.net>").

-export([
    is_authorized/2
]).

-include_lib("resource_html.hrl").

is_authorized(ReqData, Context) ->
    z_acl:wm_is_authorized(use, mod_code, ReqData, Context).

html(Context) ->
    Host = Context#context.host,
    FileName = z_context:get_q("file", Context),
    Tokens = string:tokens(FileName, "."),
    %Command = io_lib:format("cd ~s;hg st", [filename:join([z_utils:lib_dir(priv), "sites", Host])]),
    %HG = os:cmd(Command),
    %Git = os:cmd("git status"),
    %Fake = os:cmd("fake status"),
    %io:format("HG:~p~n", [HG]),
    %io:format("Git:~p~n", [Git]),
    %io:format("Fake:~p~n", [Fake]),
    case length(Tokens) >= 2 of
        true ->
            Extension = lists:last(Tokens),
            case Extension of
                "tpl" -> 
                    Vars = case file:read_file(filename:join([z_utils:lib_dir(priv), "sites", Host, "templates", FileName])) of
                        {ok, Content} -> 
                                Result = [{type, "zotonic"},
                                {content, Content},
                                {file_name, FileName}],
                                Result;
                        {error, _Reason} ->
                                [{type, "zotonic"},
                                {content, ""},
                                {file_name, FileName}]
                    end;
                "css" -> 
                    Vars = case file:read_file(filename:join([z_utils:lib_dir(priv), "sites", Host, "lib", "css", FileName])) of
                        {ok, Content} -> 
                                Result = [{type, "css"},
                                {content, Content},
                                {file_name, FileName}],
                                Result;
                        {error, _Reason} ->
                                [{type, "css"},
                                {content, ""},
                                {file_name, FileName}]
                    end;
                "js" -> 
                    Vars = case file:read_file(filename:join([z_utils:lib_dir(priv), "sites", Host, "lib", "js", FileName])) of
                        {ok, Content} -> 
                                Result = [{type, "javascript"},
                                {content, Content},
                                {file_name, FileName}],
                                Result;
                        {error, _Reason} ->
                                [{type, "javascript"},
                                {content, ""},
                                {file_name, FileName}]
                    end;
                _ -> 
                    Vars = [
                        {content, "undefined"},
                        {file_name, "undefined"}
                    ]
            end;
        _ ->
            Vars = [{content, ""}, {file_name, undefined}]
    end,
    Template = z_context:get(template, Context, "admin_code_editor.tpl"),
	Html = z_template:render(Template, Vars, Context),
	z_context:output(Html, Context).
