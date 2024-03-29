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

-module(resource_admin_code_manager).
-author("Michael Connors <michael@bring42.net>").

-export([
    is_authorized/2
]).

-include_lib("resource_html.hrl").

is_authorized(ReqData, Context) ->
    z_acl:wm_is_authorized(use, mod_code, ReqData, Context).

html(Context) ->
    Vars = [
        {files, mod_code:scan(Context)},
        {admin_code_active, true}
    ],
    Template = z_context:get(template, Context, "admin_code.tpl"),
	Html = z_template:render(Template, Vars, Context),
	z_context:output(Html, Context).
