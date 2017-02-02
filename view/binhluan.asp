<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../Connections/cn.asp" --> 
<% if(Request.ServerVariables("REQUEST_METHOD")= "GET") then
    Dim MM_editCmd
    Set MM_editCmd = Server.CreateObject ("ADODB.Command")
    MM_editCmd.ActiveConnection = MM_cn_STRING
    MM_editCmd.CommandText = "INSERT INTO dbo.tbBinhLuan (SPID, KHID, NoiDung, ThoiGian, PhanLoai) VALUES (?, ?, ?, default, ?)" 
    MM_editCmd.Prepared = true
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 3, 1, 1, Request.QueryString("spid")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param2", 3, 1, 1, Request.QueryString("khid")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param3", 203, 1, 1073741823, Request.QueryString("nd")) ' adDouble
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param4", 3, 1, 1, Request.QueryString("role")) ' adLongVarWChar
    MM_editCmd.Execute
	%>
<script>alert('Thành công !!!');location='index.asp';</script>
<%
End If
%>