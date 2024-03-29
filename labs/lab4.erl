-module(lab4).

-export([
    start/1, send_to_child/2, stop/0, child_thread/1, parent_thread/1, par_partition/3, start/0
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

make_child(I) ->
    register(get_child(I), spawn(lab4, child_thread, [I])).

make_children(0) ->
    ok;
make_children(I) ->
    make_child(I),
    make_children(I - 1).

stop_children(0) ->
    ok;
stop_children(I) ->
    send_to_child(I, stop),
    stop_children(I - 1).

start(N) ->
    checkProc(
        parent,
        fun(Pn) ->
            io:fwrite("Parent process has already started!~n"),
            error
        end,
        fun(Pn) ->
            register(Pn, spawn(lab4, parent_thread, [N - 1])),
            make_children(N - 1)
        end
    ).

send_to_child(I, M) ->
    checkProc(
        parent,
        fun(Pn) ->
            Pn ! {message, I, M},
            ok
        end
    ).

parent_thread(N) ->
    receive
        {message, I, M} ->
            checkProc(
                get_child(I),
                fun(Pn) ->
                    Pn ! M,
                    ok
                end
            ),
            parent_thread(N);
        stop ->
            stop_children(N);
        {I, error} ->
            io:fwrite("child ~i died, reloading...~n", [I]),
            make_child(I),
            parent_thread(N);
        _ ->
            parent_thread(N)
    end.

get_child(I) -> list_to_atom(string:concat("child", integer_to_list(I))).

child_thread(I) ->
    receive
        stop ->
            ok;
        die ->
            parent ! {I, error};
        Term ->
            io:fwrite("~p~n", [Term]),
            child_thread(I)
    end.

stop() ->
    checkProc(
        parent,
        fun(Pn) ->
            Pn ! stop,
            ok
        end
    ).

%%%
%%%
split_list(L, 0) -> error;
split_list(L, Len) when length(L) < Len -> [L];
split_list(L, Len) -> [lists:sublist(L, 1, Len) | split_list(lists:sublist(L, Len, Len), Len)].

par_partition_thread_proc() ->
    receive
        {From, F, L} ->
            From ! lists:partition(F, L);
        ok ->
            ok
    end.



par_partition_thread(Parent, F, List, Result) ->

    Parent ! lists:partition(F, List).

par_partition(F, List) ->
    Max = erlang:system_info(process_limit),
    self(),
    receive
        ok -> ok
    end.

par_partition(F, List, Options) ->
    self(),
    receive
        ok -> ok
    end.

start() ->
    split_list([-5, -4, 3, 5, 2, -3, 2, 1, 0], 3).
%par_partition(fun(X) -> X > 0 end, [-5, -4, 3, 5, 2, -3, 2, 1, 0]).
