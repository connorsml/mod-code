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
    init/1,
    scan/1
]).


init(Context) ->
    z_datamodel:manage(?MODULE, datamodel(), Context).

% support functions
datamodel() ->
    [{categories,
      [
       {code,
        meta,
        [{title, <<"Code">>}]},
       {template,
        code,
        [{title, <<"Template">>}]},
       {css,
        code,
        [{title, <<"Template">>}]}
      ]
     }
    ].

scan(#context{host=Host}) ->
    Templates  = filename:join([z_utils:lib_dir(priv), "sites", Host, "templates", "*.tpl"]),
    CSS  = filename:join([z_utils:lib_dir(priv), "sites", Host, "lib", "css", "*.css"]),
    Scripts  = filename:join([z_utils:lib_dir(priv), "sites", Host, "lib", "js", "*.js"]),
    Files = filelib:wildcard(Templates) ++ filelib:wildcard(CSS) ++ filelib:wildcard(Scripts),
    [ z_convert:to_atom(filename:basename(F)) ||  F <- Files ].
