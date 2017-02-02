<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../Connections/cn.asp" -->
<%
Dim rsSanpham__MMColParam
rsSanpham__MMColParam = "1"
If (Request.QueryString("ID") <> "") Then 
  rsSanpham__MMColParam = Request.QueryString("ID")
End If
%>
<%
Dim rsSanpham
Dim rsSanpham_cmd
Dim rsSanpham_numRows

Set rsSanpham_cmd = Server.CreateObject ("ADODB.Command")
rsSanpham_cmd.ActiveConnection = MM_cn_STRING
rsSanpham_cmd.CommandText = "SELECT * FROM dbo.tbSanPham WHERE ID = ?" 
rsSanpham_cmd.Prepared = true
rsSanpham_cmd.Parameters.Append rsSanpham_cmd.CreateParameter("param1", 5, 1, -1, rsSanpham__MMColParam) ' adDouble

Set rsSanpham = rsSanpham_cmd.Execute
rsSanpham_numRows = 0
%>
<%
Dim Gia1
Dim Gia2
Dim Gia4 (8)
Gia1 = CSTR(rsSanpham.Fields.Item("GiaSanPham").Value)
		Gia2 = len(Gia1)
	   Gia4(0) = Mid(Gia1, 5, 3)
	   Gia4(2) = Mid(Gia1, 1, Gia2-6)
	   Gia4(1) = Mid(Gia1, 2, 3)
%>
<div id="ansanpham">
<div class="leadmhome_in"><%=(rsSanpham.Fields.Item("TenSanPham").Value)%></div>
<table>
	<tr style="padding: 30px;">
    	<td width="40%" style="padding-right: 20px; padding-left: 20px">
        	<center><img src="../thumb/<%=(rsSanpham.Fields.Item("Anh").Value)%>" alt="thumb" height="150px" width="150px" /></center>
        </td>
        <td style="padding-left: 10px;">
      <div style="padding: 10px;"><h1><%=(rsSanpham.Fields.Item("TenSanPham").Value)%></h1></div>
      <div style="padding: 10px; text-align:center; color: red"><h3><%=Gia4(2)%>.<%=Gia4(1)%>.<%=Gia4(0)%> VND</h3></div>
      <div style="padding: 10px; text-align:center"><% if(rsSanpham.Fields.Item("TrangThai").Value) = 1 then %>
<% if((session("user")) <> "") then %>
<% if (rsSanpham.Fields.Item("TrangThai").Value) = 1 then %>
      <a class="p_na" id="loadsp" style="cursor: pointer;" title="<%=(rsSanpham.Fields.Item("ID").Value)%>"><img src="design/line3.jpg"/></a>
      <% else %>
      <img src="design/line4.jpg"/>
      <% end if %>
<% end if %>
<% end if %>
      </div>
      </td>
      </tr>
      </table>
      <div style="border-bottom: 1px solid #ccc;"></div>
      <div style=""><%=(rsSanpham.Fields.Item("ChiTiet").Value)%></div>
<br />
<% if((session("user")) <> "") then %>
<p align="center"><a class="dell" id="binhluan" align="center" binhluan="<%=(rsSanpham__MMColParam)%>"><img src="design/comment.png" /></a></p>
<% end if %>
</div>
<div class="binhluan"></div>
<%
rsSanpham.Close()
Set rsSanpham = Nothing
%>