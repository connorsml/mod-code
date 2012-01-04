%% @author Michael Connors <michael@bring42.net>
%% @copyright 2011 Michael Connors
%% @date 2011-06-14
%% @doc Module for editing code.

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

-module(mod_code).
-author("Michael Connors <michael@bring42.net>").

-mod_title("Code Editing Module").
-mod_description("Module for editing code for templates and css").
-mod_prio(500).

-include_lib("zotonic.hrl").

%% interface functions
-export([
    event/2,
    init/1,
    scan/1
]).

event({submit, {save_file, [{filename, FileName}]}, _TriggerId, _TargetId}, Context) ->
    case z_acl:is_admin(Context) of
        true ->
            Host = Context#context.host,
            Code = z_context:get_q("code", Context),
            Tokens = string:tokens(FileName, "."),
            case length(Tokens) >=2 of
                true ->
                    Extension = lists:last(Tokens),
                    case Extension of
                        "tpl" -> 
                            case file:write_file(filename:join([z_utils:lib_dir(priv), "sites", Host, "templates", FileName]), Code) of
                                ok -> z_render:growl("File Updated.", Context);
                                {error, _Reason} -> z_render:growl_error("Could not save file.", Context)
                            end;
                        "css" -> 
                            case file:write_file(filename:join([z_utils:lib_dir(priv), "sites", Host, "lib", "css", FileName]), Code) of
                                ok -> z_render:growl("File Updated.", Context);
                                {error, _Reason} -> z_render:growl_error("Could not save file.", Context)
                            end;
                        "js" -> 
                            case file:write_file(filename:join([z_utils:lib_dir(priv), "sites", Host, "lib", "js", FileName]), Code) of
                                ok -> z_render:growl("File Updated.", Context);
                                {error, _Reason} -> z_render:growl_error("Could not save file.", Context)
                            end;
                        _ -> 
                            z_render:growl_error("File missing extension.", Context)
                    end;
                _ ->
                    z_render:growl_error("Unknown file type.", Context)
            end;
	_ -> z_render:growl_error("You are not allowed to do that.", Context)
   end.

init(Context) ->
    z_datamodel:manage(?MODULE, datamodel(), Context).

% support functions
datamodel() ->
    [].

scan(#context{host=Host}) ->
    Templates  = filename:join([z_utils:lib_dir(priv), "sites", Host, "templates", "*.tpl"]),
    CSS  = filename:join([z_utils:lib_dir(priv), "sites", Host, "lib", "css", "*.css"]),
    Scripts  = filename:join([z_utils:lib_dir(priv), "sites", Host, "lib", "js", "*.js"]),
    Files = filelib:wildcard(Templates) ++ filelib:wildcard(CSS) ++ filelib:wildcard(Scripts),
    [ z_convert:to_atom(filename:basename(F)) ||  F <- Files ].
