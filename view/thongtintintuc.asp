<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../Connections/cn.asp" -->
<%
Dim rsTintuc
Dim rsTintuc_cmd
Dim rsTintuc_numRows

Set rsTintuc_cmd = Server.CreateObject ("ADODB.Command")
rsTintuc_cmd.ActiveConnection = MM_cn_STRING
rsTintuc_cmd.CommandText = "SELECT * FROM dbo.tbTinTuc WHERE ID = ?" 
rsTintuc_cmd.Prepared = true
rsTintuc_cmd.Parameters.Append rsTintuc_cmd.CreateParameter("param1", 5, 1, -1, Request.QueryString("id")) ' adDouble

Set rsTintuc = rsTintuc_cmd.Execute
rsTintuc_numRows = 0
%>
<div class="leadmhome_in">Tin tức</div>
      <div style="padding: 10px;"><h1><%=(rsTintuc.Fields.Item("TieuDe").Value)%></h1></div>
      <div style="border-bottom: 1px solid #ccc;"></div>
      <div style="padding: 10px"><%=(rsTintuc.Fields.Item("NoiDung").Value)%></div>
<%
rsTintuc.Close()
Set rsTintuc = Nothing
%>
