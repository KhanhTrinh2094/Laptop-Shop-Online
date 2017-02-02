<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../Connections/cn.asp" -->
<% if(Request.ServerVariables("REQUEST_METHOD")= "GET" AND (Request.QueryString("tieude")) <> "") then
    Dim MM_editCmd
    Set MM_editCmd = Server.CreateObject ("ADODB.Command")
    MM_editCmd.ActiveConnection = MM_cn_STRING
    MM_editCmd.CommandText = "INSERT INTO dbo.tbPhanHoi (KHID, ThoiGian, NoiDung, TieuDe) VALUES (?, default, ?, ?)" 
    MM_editCmd.Prepared = true
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 3, 1, 1, Request.QueryString("id")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param3", 203, 1, 1073741823, Request.QueryString("nd")) ' adDouble
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param4", 203, 1, 1073741823, Request.QueryString("tieude")) ' adLongVarWChar
    MM_editCmd.Execute
	%>
<script>alert('Thành công !!!');location='index.asp';</script>
<%
End If
%>
<%
Dim rsThanhvien__MMColParam
rsThanhvien__MMColParam = "Trinh"
If (Session("user") <> "") Then 
  rsThanhvien__MMColParam = Session("user")
End If
%>
<%
Dim rsThanhvien
Dim rsThanhvien_cmd
Dim rsThanhvien_numRows

Set rsThanhvien_cmd = Server.CreateObject ("ADODB.Command")
rsThanhvien_cmd.ActiveConnection = MM_cn_STRING
rsThanhvien_cmd.CommandText = "SELECT * FROM dbo.tbKhachHang WHERE TenDangNhap = ?" 
rsThanhvien_cmd.Prepared = true
rsThanhvien_cmd.Parameters.Append rsThanhvien_cmd.CreateParameter("param1", 200, 1, 20, rsThanhvien__MMColParam) ' adDouble

Set rsThanhvien = rsThanhvien_cmd.Execute
rsThanhvien_numRows = 0
%>
<div class="anxem">
<div class="leadmhome_in">Gửi phản hồi</div>
<% if (NOT rsThanhvien.EOF) then %>
<form id="form1" name="form1" method="post" action="" class="frm_submit">
<table width="622" height="100" border="0" style="padding: 10px;">
  <tr>
    <td><span class="style5">Tiêu đề </span></td>
    <td><div align="center">
    
        <input type="text" name="tieude" id="tieude" />
     <td width="41"><div align="center"><span class="xoa" id="gopy">Gửi</span></div></td>
      </div></td>
  </tr>
  
  <tr>
    <td><span class="style5">Nội dung </span></td>
    <td><div align="center">
    
        <textarea name="nd" id="nd"></textarea>
      </div></td>
  </tr>
  </table>
<input name="khid" type="hidden" id="khid" value="<%=(rsThanhvien.Fields.Item("ID").Value)%>"/>
</form>
</div>
<% else %>
<p style="color:red; padding: 10px;">Vui lòng đăng nhập để gửi phản hồi</p>
<% end if %>
<%
rsThanhvien.Close()
Set rsThanhvien = Nothing
%>
