-module(echo).

-export([
    start/0,
    print/1,
    stop/0
]).

start() ->
    io:fwrite("Started<0.33.0>~n", []),
    ok.

print(Term) ->
    io:fwrite("~s~n", [Term]),
    ok.

stop() ->
    io:fwrite("Stopped!~n"),
    halt(),
    ok.
