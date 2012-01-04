%% @author Michael Connors <michael@bring42.net>
%% @copyright 2012 Michael Connors
%% @doc Returns a file type based on an extension

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

-module(filter_file_type).
-export([file_type/2]).

-include("zotonic.hrl").

file_type(undefined, _Context) ->
    undefined;
file_type(Input, Context) when is_binary(Input) ->
    file_type(binary_to_list(Input), Context);
file_type(Input, Context) when is_atom(Input) ->
    file_type(atom_to_list(Input), Context);
file_type(Input, _Context) when is_list(Input) ->
    case string:tokens(Input, ".") of 
        [] -> undefined;
        [_OneToken] -> undefined;
        Tokens when is_list(Tokens) -> 
            case lists:last(Tokens) of
                "tpl" -> <<"Template">>;
                "js" -> <<"JavaScript">>;
                "css" -> <<"CSS">>;
                _Other -> <<"Unknown">>
            end;
        _Other -> 
            undefined
    end;

file_type(_Input, _Context) ->
    undefined.
