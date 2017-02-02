<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../Connections/cn.asp" -->
<%
Dim rsBinhluan__MMColParam
rsBinhluan__MMColParam = 1
If (Request.QueryString("ID") <> "") Then 
  rsBinhluan__MMColParam = Request.QueryString("ID")
End If
%>
<%
Dim rsBinhluan
Dim rsBinhluan_cmd
Dim rsBinhluan_numRows

Set rsBinhluan_cmd = Server.CreateObject ("ADODB.Command")
rsBinhluan_cmd.ActiveConnection = MM_cn_STRING
rsBinhluan_cmd.CommandText = "SELECT * FROM dbo.tbBinhLuan WHERE SPID = ? orDER BY ID DesC" 
rsBinhluan_cmd.Prepared = true
rsBinhluan_cmd.Parameters.Append rsBinhluan_cmd.CreateParameter("param1", 5, 1, -1, rsBinhluan__MMColParam) ' adDouble

Set rsBinhluan = rsBinhluan_cmd.Execute
rsBinhluan_numRows = 0
%>
<%
Dim rsTrinh__MMColParam
rsTrinh__MMColParam = "1"
If (Session("user") <> "") Then 
  rsTrinh__MMColParam = Session("user")
End If
%>
<%
Dim rsTrinh
Dim rsTrinh_cmd
Dim rsTrinh_numRows

Set rsTrinh_cmd = Server.CreateObject ("ADODB.Command")
rsTrinh_cmd.ActiveConnection = MM_cn_STRING
rsTrinh_cmd.CommandText = "SELECT * FROM dbo.tbKhachHang WHERE TenDangNhap = ?" 
rsTrinh_cmd.Prepared = true
rsTrinh_cmd.Parameters.Append rsTrinh_cmd.CreateParameter("param1", 200, 1, 20, rsTrinh__MMColParam) ' adVarChar

Set rsTrinh = rsTrinh_cmd.Execute
rsTrinh_numRows = 0
%>
<%
Dim Repeat1__numRows
Dim Repeat1__index

Repeat1__numRows = -1
Repeat1__index = 0
rsBinhluan_numRows = rsBinhluan_numRows + Repeat1__numRows
%>
<div class="anxem">
<div class="leadmhome_in">Bình luận</div>
<% if (NOT rsBinhluan.EOF) then %>
<%
Dim rsThanhvien
Dim rsThanhvien_cmd
Dim rsThanhvien_numRows
%>
<%
Dim rsBinh
Dim rsBinh_cmd
Dim rsBinh_numRows

Set rsBinh_cmd = Server.CreateObject ("ADODB.Command")
rsBinh_cmd.ActiveConnection = MM_cn_STRING
rsBinh_cmd.CommandText = "SELECT * FROM dbo.tbKhachHang WHERE TenDangNhap = ?" 
rsBinh_cmd.Prepared = true
rsBinh_cmd.Parameters.Append rsBinh_cmd.CreateParameter("param1", 200, 1, 30, Session("user")) ' adDouble

Set rsBinh = rsBinh_cmd.Execute
rsBinh_numRows = 0
%>

<div id="ansua">
<table width="622" border="0" style="padding: 10px;" class="frm_submit">
  <% While ((Repeat1__numRows <> 0) AND (NOT rsBinhluan.EOF))
  Set rsThanhvien_cmd = Server.CreateObject ("ADODB.Command")
rsThanhvien_cmd.ActiveConnection = MM_cn_STRING
rsThanhvien_cmd.CommandText = "SELECT * FROM dbo.tbKhachHang WHERE ID = ?" 
rsThanhvien_cmd.Prepared = true
rsThanhvien_cmd.Parameters.Append rsThanhvien_cmd.CreateParameter("param1", 5, 1, -1, (rsBinhluan.Fields.Item("KHID").Value)) ' adDouble

Set rsThanhvien = rsThanhvien_cmd.Execute
rsThanhvien_numRows = 0

if((rsThanhvien.Fields.Item("VaiTro").Value) = 1 OR (rsBinhluan.Fields.Item("PhanLoai").Value) = 1) then %>
    <tr style="padding: 50px;">
      <td width="102" style="color: red; font-weight: bold; padding: 30px"><span class="style5"><%=(rsThanhvien.Fields.Item("TenDangNhap").Value)%></span></td>
      <td width="465" style="color: red; font-weight: bold;"><%=(rsBinhluan.Fields.Item("NoiDung").Value)%></td>
    </tr>
<% else %>
    <tr>
      <td width="102" style="padding: 30px"><%=(rsThanhvien.Fields.Item("TenDangNhap").Value)%></td>
      <td width="465"><%=(rsBinhluan.Fields.Item("NoiDung").Value)%></td>
    </tr>
<% end if %>
    <% 
  Repeat1__index=Repeat1__index+1
  Repeat1__numRows=Repeat1__numRows-1
  rsBinhluan.MoveNext()
Wend
%>
</table>
<% else %>
<p style="color:red; padding: 10px;">Chưa có bình luận cho sản phẩm này</p>
<% end if %>
</div>

</div>
<div class="leadmhome_in">Gửi bình luận</div>
<form id="form1" name="form1" method="post" action="" class="frm_submit">
<table width="622" height="100" border="0" style="padding: 10px;">
  <tr>
    <td><span class="style5">Nội dung </span></td>
    <td><div align="center">
    
        <textarea name="nd" id="nd"></textarea>
     <td width="41"><div align="center"><span class="xoa" id="bl">Gửi</span></div></td>
      </div></td>
  </tr>
  </table>
<input name="spid" type="hidden" id="spid" value="<%=(Request.QueryString("ID"))%>"/>
<input name="khid" type="hidden" id="khid" value="<%=(rsTrinh.Fields.Item("ID").Value)%>"/>
<input name="role" type="hidden" id="role" value="<%=(rsTrinh.Fields.Item("VaiTro").Value)%>"/>
</form>
  
<%
rsBinhluan.Close()
Set rsBinhluan = Nothing
%>
<%
rsTrinh.Close()
Set rsTrinh = Nothing
%>
