<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../Connections/cn.asp" --> 
<% if(Request.ServerVariables("REQUEST_METHOD")= "GET") then
    Dim MM_editCmd
Dim TrangThai
Dim VaiTro
TrangThai = 1
Vaitro = 0
    Set MM_editCmd = Server.CreateObject ("ADODB.Command")
    MM_editCmd.ActiveConnection = MM_cn_STRING
    MM_editCmd.CommandText = "INSERT INTO dbo.tbKhachHang (TenDangNhap, MatKhau, HoTen,DiaChi, Email, SoDienThoai, GioiTinh, TrangThai, VaiTro) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)" 
    MM_editCmd.Prepared = true
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 200, 1, 20, Request.QueryString("tendangnhap")) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param2", 200, 1, 20, Request.QueryString("matkhau")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param3", 203, 1, 50, Request.QueryString("hoten")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param4", 203, 1, 300, Request.QueryString("diachi")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param5", 200, 1, 50, Request.QueryString("email")) ' adDouble
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param6", 3, 1, 11, Request.QueryString("sodienthoai")) ' adDouble
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param7", 3, 1, 1, Request.QueryString("gt")) ' adLongVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param8", 3, 1, -1, TrangThai) ' adDouble
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param9", 3, 1, -1, VaiTro) ' adLongVarChar
    MM_editCmd.Execute
    MM_editCmd.ActiveConnection.Close
%>
<script>alert('Đăng ký thành công !!!');location='?';</script>
<%
End If
%>