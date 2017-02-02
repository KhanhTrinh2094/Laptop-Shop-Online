<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
Dim pass
Dim rpass
pass = Request.QueryString("pass")
rpass = Request.QueryString("rpass")

if((len(pass)) < 6) then
    response.Write("Mật khẩu quá ngắn")
    elseif (pass = "") then
    response.Write("Mật khẩu không được để trống")
    elseif (rpass = "") then
    response.Write("Nhập lại mật khẩu")
    elseif (pass <> rpass) then
    response.Write("Mật khẩu không trùng khớp")
    else
    response.Write("OK")
end if
%>