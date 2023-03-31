-module(echo).

-export([
    start/0,
    print/1,
    stop/0
]).

start() ->
    ECHO = whereis(echo),
    if
        ECHO /= undefined ->
            io:fwrite("Process is already started!~n"),
            error;
        true ->
            PID = spawn(fun thread/0),
            register(echo, PID),
            io:fwrite(
                "Started~n~p", [PID]
            ),
            ok
    end.

print(Term) ->
    echo ! Term,
    ok.

stop() ->
    PID = whereis(echo),
    if
        PID == undefined ->
            io:fwrite("Process wasnt started!~n"),
            error;
        true ->
            echo ! stop,
            io:fwrite("Stopped!~n"),
            ok
    end.

thread() ->
    receive
        stop ->
            void;
        Term ->
            io:fwrite("~s~n", [Term]),
            thread()
    end.
