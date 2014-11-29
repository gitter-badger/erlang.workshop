-module(login).
-compile(export_all).
-include_lib("n2o/include/wf.hrl").

main() ->
  #dtl{file="login",app=n2o_sample,bindings=[{body,body()}]}.

body() ->
  #span{body=[
   #span{id=display},#br{},
   #span{body="Username:"}, #textbox{id=user}, #br{},
   #span{body="Password:"}, #textbox{id=pass}, #br{},
   #button{id=login,body="Login",postback=login,source=[user,pass]}
   ]}.

event({12,_}) -> io:format("12!");

event(login) ->
    wf:info(?MODULE,"Login Pressed: ~p ~p ~n",
        [wf:q(user),wf:q(pass)]),
    wf:user(wf:js_escape(wf:html_encode(wf:q(user)))),
    wf:redirect("/index");

event(init) ->
    wf:info(?MODULE,"Pid~p~n",[self()]);

event(_) -> ok.

