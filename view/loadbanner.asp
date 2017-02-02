<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../Connections/cn.asp" -->

<%
Dim rsHsx
Dim rsHsx_cmd
Dim rsHsx_numRows

Set rsHsx_cmd = Server.CreateObject ("ADODB.Command")
rsHsx_cmd.ActiveConnection = MM_cn_STRING
rsHsx_cmd.CommandText = "SELECT * FROM dbo.tbHangSanXuat" 
rsHsx_cmd.Prepared = true

Set rsHsx = rsHsx_cmd.Execute
rsHsx_numRows = 0
%>
<%
Dim rsHsx2
Dim rsHsx2_numRows
Set rsHsx2 = rsHsx_cmd.Execute
rsHsx2_numRows = 0
%>
<%
Dim rsChip
Dim rsChip_cmd
Dim rsChip_numRows

Set rsChip_cmd = Server.CreateObject ("ADODB.Command")
rsChip_cmd.ActiveConnection = MM_cn_STRING
rsChip_cmd.CommandText = "SELECT DISTINCT Chip FROM dbo.tbSanPham" 
rsChip_cmd.Prepared = true

Set rsChip = rsChip_cmd.Execute
rsChip_numRows = 0
%>
<%
Dim Repeat1__numRows
Dim Repeat1__index

Repeat1__numRows = -1
Repeat1__index = 0
rsHsx_numRows = rsHsx_numRows + Repeat1__numRows
%>
<%
Dim Repeat2__numRows
Dim Repeat2__index

Repeat2__numRows = -1
Repeat2__index = 0
rsChip_numRows = rsChip_numRows + Repeat2__numRows
%>
<%
Dim Repeat3__numRows
Dim Repeat3__index

Repeat3__numRows = -1
Repeat3__index = 0
rsHsx2_numRows = rsHsx2_numRows + Repeat3__numRows
%>
<%
Dim rsChip2
Dim rsChip2_numRows
Set rsChip2 = rsChip_cmd.Execute
rsChip2_numRows = 0
%>
<%
Dim Repeat4__numRows
Dim Repeat4__index

Repeat4__numRows = -1
Repeat4__index = 0
rsChip2_numRows = rsChip2_numRows + Repeat4__numRows
%>
<div id="loadbanner">
<center>
<ul id="css3menu1" class="topmenu">
	<li class="topfirst"><a class="dell" id="home" style="height:18px;line-height:18px;" data-tooltip="stickyhome"><img src="design/css3/home.png"/>Trang chủ</a></li>
	<li class="topmenu"><a style="height:18px;line-height:18px;" data-tooltip="stickyhsx"><span><img src="design/css3/next.gif" alt=""/>Hãng Sản Xuất</span></a>
	<ul>
  <% While ((Repeat1__numRows <> 0) AND (NOT rsHsx.EOF)) %>
      <li><a class="dell" id="hangsx" mahang="<%=(rsHsx.Fields.Item("ID").Value)%>"><%=(rsHsx.Fields.Item("TenHang").Value)%></a></li>
    <% 
  Repeat1__index=Repeat1__index+1
  Repeat1__numRows=Repeat1__numRows-1
  rsHsx.MoveNext()
Wend
%>
	</ul>
    </li>

	<li class="topmenu"><a style="height:18px;line-height:18px;" data-tooltip="stickygia"><span><img src="design/css3/next.gif" alt=""/>Giá</span></a>
	<ul>
		<li><a class="dell" id="gia" gia="1">5tr-8tr</a></li>
		<li><a class="dell" id="gia" gia="2">8tr-13tr</a></li>
		<li><a class="dell" id="gia" gia="3">Trên 13tr</a></li>
	</ul></li>
    
	<li class="topmenu"><a class="dell" id="tintuc" style="height:18px;line-height:18px;" data-tooltip="stickytin"><img src="design/css3/next.gif" alt=""/>Tin tức</a>
	</li>
    
<% if(Session("user") = "") then %>
	<li class="toplast"><a class="dell" id="dangky" style="height:18px;line-height:18px;"><img src="design/css3/next.gif" alt=""/>Đăng ký</a>
   </li>
	<%
    else
    %>
	<li class="topmenu"><a href="?" style="height:18px;line-height:18px;"><img src="design/css3/next.gif" alt=""/>Chào <b style="color:red"><%=Session("user")%><b class="demtb"></b></b></a>
    <ul>
		<li><a id="dell" class="user" user="">Thông tin cá nhân</a></li>
        <li><a id="dell" class="gopy">Gửi phản hồi</a></li>
        <li><a class="dell" id="changepass" user="">Đổi mật khẩu</a></li>
        <li><a class="logout">Thoát</a></li>
    </ul></li>
    <li class="toplast"><a class="dell" id="giohang" style="color: red;" data-tooltip="stickyh">Giỏ hàng</a>
        <% end if %>
	
    
    </li>
</ul>




</center>