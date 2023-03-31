-module(echo).

-export([
    start/0,
    print/1,
    stop/0
]).

checkProc(ProcName, Success, Fail) ->
    PID = whereis(ProcName),
    if
        PID == undefined ->
            Fail(ProcName);
        true ->
            Success(ProcName)
    end.
checkProc(ProcName, Success) ->
    checkProc(ProcName, Success, fun(Pn) ->
        io:fwrite("Process \"~s\" wasn't started!~n", [Pn]),
        error
    end).

start() ->
    checkProc(
        echo,
        fun(Pn) ->
            io:fwrite("Process is already started!~n"),
            error
        end,
        fun(Pn) ->
            PID = spawn(fun thread/0),
            register(Pn, PID),
            io:fwrite(
                "Started~n~p", [PID]
            ),
            ok
        end
    ).

print(Term) ->
    checkProc(echo, fun(Pn) ->
        Pn ! Term,
        ok
    end).

stop() ->
    checkProc(echo, fun(Pn) ->
        Pn ! stop,
        io:fwrite("Stopped!~n"),
        ok
    end).

thread() ->
    receive
        stop ->
            void;
        Term ->
            io:fwrite("~p~n", [Term]),
            thread()
    end.
