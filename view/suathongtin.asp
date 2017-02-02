<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../Connections/cn.asp" -->
<%
Dim rsThanhvien__MMColParam
rsThanhvien__MMColParam = "1"
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
rsThanhvien_cmd.Parameters.Append rsThanhvien_cmd.CreateParameter("param1", 200, 1, 20, rsThanhvien__MMColParam) ' adVarChar

Set rsThanhvien = rsThanhvien_cmd.Execute
rsThanhvien_numRows = 0
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<div class="anxem">
<div class="leadmhome_in">Sửa thông tin cá nhân</div>
<div id="ansua">
<form id="form1" name="form1" method="post" action="" class="frm_submit">
<table width="622" height="450" border="0" style="padding: 10px;">
  <tr>
    <td width="102"><span class="style5">Họ tên </span></td>
    <td width="465"><div align="center">
      
        <input name="hoten" type="text" id="hoten" value="<%=(rsThanhvien.Fields.Item("HoTen").Value)%>" />
      
      </div></td>
    <td width="41"><div align="center"><span class="xoa" id="xong">Xong</span>
  </tr>
  
  <tr>
    <td><span class="style5">Địa chỉ</span></td>
    <td><div align="center">
    
        <input name="dc" type="text" id="dc" value="<%=(rsThanhvien.Fields.Item("DiaChi").Value)%>" />
     
      </div></td>
  </tr>
  <tr>
    <td><span class="style5">Email</span></td>
    <td><div align="center" id="laytt" user="">
     
        <input name="mail" type="text" id="mail" value="<%=(rsThanhvien.Fields.Item("Email").Value)%>" />
    
      </div></td>
  </tr>
  <tr>
    <td><span class="style5">Số điện thoại</span></td>
    <td><div align="center">
      
        <input name="sdt" type="text" id="sdt" value="<%=(rsThanhvien.Fields.Item("SoDienThoai").Value)%>"/>
        <tr>
          <td>Giới tính</td>
          <td><div align="center">
         <select name="select" id="gt">';
        <% if((rsThanhvien.Fields.Item("GioiTinh").Value) = 1) then %>
          <option value="1">Nam</option>
          <option value="0">Nữ</option>
        <% else %>
          <option value="0">Nữ</option>
          <option value="1">Nam</option>
		<% end if %>
        </select>
         </td>
        </tr>
      </div></td>
  </tr>
</table>
</form>
</div>
<% if(Request.ServerVariables("REQUEST_METHOD")= "GET" AND (Request.QueryString("hoten")) <> "" AND (Request.QueryString("dc")) <> "") then
    Dim MM_editCmd
    Set MM_editCmd = Server.CreateObject ("ADODB.Command")
    MM_editCmd.ActiveConnection = MM_cn_STRING
    MM_editCmd.CommandText = "UPDATE dbo.tbKhachHang SET HoTen = ?, DiaChi = ?, Email = ?, SoDienThoai = ?, GioiTinh = ? WHERE TenDangNhap = ?" 
    MM_editCmd.Prepared = true
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 203, 1, 1073741823, Request.QueryString("hoten")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param2", 203, 1, 1073741823, Request.QueryString("dc")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param3", 200, 1, 50, Request.QueryString("mail")) ' adDouble
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param4", 3, 1, 11, Request.QueryString("sdt")) ' adDouble
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param5", 3, 1, 1, Request.QueryString("gt")) ' adLongVarWChar
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param6", 200, 1, 20, rsThanhvien__MMColParam) ' adVarWChar
    MM_editCmd.Execute
	%>
<%
End If
%>
         <%
rsThanhvien.Close()
Set rsThanhvien = Nothing
%>
</div>
</body>
</html>