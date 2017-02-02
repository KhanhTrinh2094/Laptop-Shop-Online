<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="Connections/cn.asp" -->
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
Dim Repeat11__numRows
Dim Repeat11__index

Repeat11__numRows = -1
Repeat11__index = 0
rsHsx_numRows = rsHsx_numRows + Repeat11__numRows
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

<%
Dim rsSanpham
Dim rsSanpham_cmd
Dim rsSanpham_numRows

Set rsSanpham_cmd = Server.CreateObject ("ADODB.Command")
rsSanpham_cmd.ActiveConnection = MM_cn_STRING
rsSanpham_cmd.CommandText = "SELECT * FROM dbo.tbSanPham ORDER BY ID DESC" 
rsSanpham_cmd.Prepared = true

Set rsSanpham = rsSanpham_cmd.Execute
rsSanpham_numRows = 0
%>
<%
Dim Repeat1__numRows
Dim Repeat1__index

Repeat1__numRows = 16
Repeat1__index = 0
rsSanpham_numRows = rsSanpham_numRows + Repeat1__numRows
%>
<%
'  *** Recordset Stats, Move To Record, and Go To Record: declare stats variables

Dim rsSanpham_total
Dim rsSanpham_first
Dim rsSanpham_last

' set the record count
rsSanpham_total = rsSanpham.RecordCount

' set the number of rows displayed on this page
If (rsSanpham_numRows < 0) Then
  rsSanpham_numRows = rsSanpham_total
Elseif (rsSanpham_numRows = 0) Then
  rsSanpham_numRows = 1
End If

' set the first and last displayed record
rsSanpham_first = 1
rsSanpham_last  = rsSanpham_first + rsSanpham_numRows - 1

' if we have the correct record count, check the other stats
If (rsSanpham_total <> -1) Then
  If (rsSanpham_first > rsSanpham_total) Then
    rsSanpham_first = rsSanpham_total
  End If
  If (rsSanpham_last > rsSanpham_total) Then
    rsSanpham_last = rsSanpham_total
  End If
  If (rsSanpham_numRows > rsSanpham_total) Then
    rsSanpham_numRows = rsSanpham_total
  End If
End If
%>
<%
Dim MM_paramName 
%>
<%
' *** Move To Record and Go To Record: declare variables

Dim MM_rs
Dim MM_rsCount
Dim MM_size
Dim MM_uniqueCol
Dim MM_offset
Dim MM_atTotal
Dim MM_paramIsDefined

Dim MM_param
Dim MM_index

Set MM_rs    = rsSanpham
MM_rsCount   = rsSanpham_total
MM_size      = rsSanpham_numRows
MM_uniqueCol = ""
MM_paramName = ""
MM_offset = 0
MM_atTotal = false
MM_paramIsDefined = false
If (MM_paramName <> "") Then
  MM_paramIsDefined = (Request.QueryString(MM_paramName) <> "")
End If
%>
<%
' *** Move To Record: handle 'index' or 'offset' parameter

if (Not MM_paramIsDefined And MM_rsCount <> 0) then

  ' use index parameter if defined, otherwise use offset parameter
  MM_param = Request.QueryString("index")
  If (MM_param = "") Then
    MM_param = Request.QueryString("offset")
  End If
  If (MM_param <> "") Then
    MM_offset = Int(MM_param)
  End If

  ' if we have a record count, check if we are past the end of the recordset
  If (MM_rsCount <> -1) Then
    If (MM_offset >= MM_rsCount Or MM_offset = -1) Then  ' past end or move last
      If ((MM_rsCount Mod MM_size) > 0) Then         ' last page not a full repeat region
        MM_offset = MM_rsCount - (MM_rsCount Mod MM_size)
      Else
        MM_offset = MM_rsCount - MM_size
      End If
    End If
  End If

  ' move the cursor to the selected record
  MM_index = 0
  While ((Not MM_rs.EOF) And (MM_index < MM_offset Or MM_offset = -1))
    MM_rs.MoveNext
    MM_index = MM_index + 1
  Wend
  If (MM_rs.EOF) Then 
    MM_offset = MM_index  ' set MM_offset to the last possible record
  End If

End If
%>
<%
' *** Move To Record: if we dont know the record count, check the display range

If (MM_rsCount = -1) Then

  ' walk to the end of the display range for this page
  MM_index = MM_offset
  While (Not MM_rs.EOF And (MM_size < 0 Or MM_index < MM_offset + MM_size))
    MM_rs.MoveNext
    MM_index = MM_index + 1
  Wend

  ' if we walked off the end of the recordset, set MM_rsCount and MM_size
  If (MM_rs.EOF) Then
    MM_rsCount = MM_index
    If (MM_size < 0 Or MM_size > MM_rsCount) Then
      MM_size = MM_rsCount
    End If
  End If

  ' if we walked off the end, set the offset based on page size
  If (MM_rs.EOF And Not MM_paramIsDefined) Then
    If (MM_offset > MM_rsCount - MM_size Or MM_offset = -1) Then
      If ((MM_rsCount Mod MM_size) > 0) Then
        MM_offset = MM_rsCount - (MM_rsCount Mod MM_size)
      Else
        MM_offset = MM_rsCount - MM_size
      End If
    End If
  End If

  ' reset the cursor to the beginning
  If (MM_rs.CursorType > 0) Then
    MM_rs.MoveFirst
  Else
    MM_rs.Requery
  End If

  ' move the cursor to the selected record
  MM_index = 0
  While (Not MM_rs.EOF And MM_index < MM_offset)
    MM_rs.MoveNext
    MM_index = MM_index + 1
  Wend
End If
%>
<%
' *** Move To Record: update recordset stats

' set the first and last displayed record
rsSanpham_first = MM_offset + 1
rsSanpham_last  = MM_offset + MM_size

If (MM_rsCount <> -1) Then
  If (rsSanpham_first > MM_rsCount) Then
    rsSanpham_first = MM_rsCount
  End If
  If (rsSanpham_last > MM_rsCount) Then
    rsSanpham_last = MM_rsCount
  End If
End If

' set the boolean used by hide region to check if we are on the last record
MM_atTotal = (MM_rsCount <> -1 And MM_offset + MM_size >= MM_rsCount)
%>
<%
' *** Go To Record and Move To Record: create strings for maintaining URL and Form parameters

Dim MM_keepNone
Dim MM_keepURL
Dim MM_keepForm
Dim MM_keepBoth

Dim MM_removeList
Dim MM_item
Dim MM_nextItem

' create the list of parameters which should not be maintained
MM_removeList = "&index="
If (MM_paramName <> "") Then
  MM_removeList = MM_removeList & "&" & MM_paramName & "="
End If

MM_keepURL=""
MM_keepForm=""
MM_keepBoth=""
MM_keepNone=""

' add the URL parameters to the MM_keepURL string
For Each MM_item In Request.QueryString
  MM_nextItem = "&" & MM_item & "="
  If (InStr(1,MM_removeList,MM_nextItem,1) = 0) Then
    MM_keepURL = MM_keepURL & MM_nextItem & Server.URLencode(Request.QueryString(MM_item))
  End If
Next

' add the Form variables to the MM_keepForm string
For Each MM_item In Request.Form
  MM_nextItem = "&" & MM_item & "="
  If (InStr(1,MM_removeList,MM_nextItem,1) = 0) Then
    MM_keepForm = MM_keepForm & MM_nextItem & Server.URLencode(Request.Form(MM_item))
  End If
Next

' create the Form + URL string and remove the intial '&' from each of the strings
MM_keepBoth = MM_keepURL & MM_keepForm
If (MM_keepBoth <> "") Then 
  MM_keepBoth = Right(MM_keepBoth, Len(MM_keepBoth) - 1)
End If
If (MM_keepURL <> "")  Then
  MM_keepURL  = Right(MM_keepURL, Len(MM_keepURL) - 1)
End If
If (MM_keepForm <> "") Then
  MM_keepForm = Right(MM_keepForm, Len(MM_keepForm) - 1)
End If

' a utility function used for adding additional parameters to these strings
Function MM_joinChar(firstItem)
  If (firstItem <> "") Then
    MM_joinChar = "&"
  Else
    MM_joinChar = ""
  End If
End Function
%>
<%
' *** Move To Record: set the strings for the first, last, next, and previous links

Dim MM_keepMove
Dim MM_moveParam
Dim MM_moveFirst
Dim MM_moveLast
Dim MM_moveNext
Dim MM_movePrev
Dim Gia1
Dim Gia2
Dim Gia3
Dim Gia4 (8)
Dim MM_urlStr
Dim MM_paramList
Dim MM_paramIndex
Dim MM_nextParam

MM_keepMove = MM_keepBoth
MM_moveParam = "index"

' if the page has a repeated region, remove 'offset' from the maintained parameters
If (MM_size > 1) Then
  MM_moveParam = "offset"
  If (MM_keepMove <> "") Then
    MM_paramList = Split(MM_keepMove, "&")
    MM_keepMove = ""
    For MM_paramIndex = 0 To UBound(MM_paramList)
      MM_nextParam = Left(MM_paramList(MM_paramIndex), InStr(MM_paramList(MM_paramIndex),"=") - 1)
      If (StrComp(MM_nextParam,MM_moveParam,1) <> 0) Then
        MM_keepMove = MM_keepMove & "&" & MM_paramList(MM_paramIndex)
      End If
    Next
    If (MM_keepMove <> "") Then
      MM_keepMove = Right(MM_keepMove, Len(MM_keepMove) - 1)
    End If
  End If
End If

' set the strings for the move to links
If (MM_keepMove <> "") Then 
  MM_keepMove = Server.HTMLEncode(MM_keepMove) & "&"
End If

MM_urlStr = Request.ServerVariables("URL") & "?" & MM_keepMove & MM_moveParam & "="

MM_moveFirst = 0
MM_moveLast  = -1
MM_moveNext  = CStr(MM_offset + MM_size)
If (MM_offset - MM_size < 0) Then
  MM_movePrev = 0
Else
  MM_movePrev = CStr(MM_offset - MM_size)
End If
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Laptop Shop Online</title>
<link href="design/css.css" rel="stylesheet" />

<link href="design/css3/style.css" rel="stylesheet" type="text/css" />
<link href="design/stickytooltip.css" rel="stylesheet" type="text/css">
<link href="design/generic.css" rel="stylesheet" type="text/css" />
 <link href="design/js-image-slider.css" rel="stylesheet" type="text/css" />
 <link href="design/slider.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="http://ajax.Googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<script type="text/javascript" src="design/stickytooltip.js"></script>
<script language="javascript" src="design/laptop.js"></script>
<script src="design/js-image-slider.js" type="text/javascript"></script>
<script src="design/jquery-slider.js" type="text/javascript"></script>

</head>
<body>
<% if(Session("user") = "") then %>
<div class="removelg">
	<div class="login-bar">
		<a href="#" class="login-button" style="font-style: italic;z-index: 3;"> Đăng nhập</a>
	</div>
</div>
	<div class="overlay"></div>
	<form class="login">
		<div class="login-header">
			<span style="font-style: italic;font-size: 20;font-family: g2">Đăng nhập</span>
			<a href="#" class="close">x</a>
		</div>
		<div class="login-content">
			<label for="name">Tài khoản</label>
			<input type="text" value="Tài khoản" method="post" id="tendangnhap" class="name" name="tendangnhap" onFocus="this.value='';"/><div id="loadck"></div><div class="succ" style="color:red"></div>
			<label for="pass">Mật khẩu</label>
			<input type="password" value="password"  method="post" id="matkhau" class="pass" name="matkhau" onFocus="this.value='';"/>
			<input type="button" value="Log In" class="loginsubmit" name="dangnhap" onsubmit="return false"/>
		</div>
	</form>
<% end if %>
<div class="showlogin"></div>
<div class="div2" id="top1">
        <div class="floatLeft" >
            <div id="mcts1">
                <img width="100" height="70"src="design/slide/1.jpg" />
                <img width="100" height="38" src="design/slide/2.png" />
                <img width="100" height="38" src="design/slide/3.jpg" />
                <img width="100" height="38" src="design/slide/4.jpg" />
                <img width="100" height="38" src="design/slide/5.png" />
                <img width="100" height="38" src="design/slide/6.png" />
                <img width="100" height="38" src="design/slide/7.jpg" />
                
            </div>
        </div>
        <div class="floatLeft">
            <div id="sliderFrame">
                <div id="slider">
                   
                    <img width="600" height="288" src="design/slide/1.jpg" />
                    <img width="600" height="288" src="design/slide/2.png" />
                    <img width="600" height="288" src="design/slide/3.jpg" />
                    <img width="600" height="288" src="design/slide/4.jpg" />
                    <img width="600" height="288" src="design/slide/5.png" />
                    <img width="600" height="288" src="design/slide/6.png" />
                    <img width="600" height="288" src="design/slide/7.jpg" />

                    
                </div>
            </div>
        </div>
       </div>  

<div id="loadbanner">
<center>
<ul id="css3menu1" class="topmenu">
	<li class="topfirst"><a class="dell" id="home" style="height:18px;line-height:18px;" data-tooltip="stickyhome"><img src="design/css3/home.png"/>Trang chủ</a></li>
	<li class="topmenu"><a style="height:18px;line-height:18px;" data-tooltip="stickyhsx"><span><img src="design/css3/next.gif" alt=""/>Hãng Sản Xuất</span></a>
	<ul>
  <% While ((Repeat11__numRows <> 0) AND (NOT rsHsx.EOF)) %>
      <li><a class="dell" id="hangsx" mahang="<%=(rsHsx.Fields.Item("ID").Value)%>"><%=(rsHsx.Fields.Item("TenHang").Value)%></a></li>
    <% 
  Repeat11__index=Repeat11__index+1
  Repeat11__numRows=Repeat11__numRows-1
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
    </ul>
    </li>
    <li class="toplast"><a class="dell" id="giohang" style="color: red;" data-tooltip="stickyh">Giỏ hàng</a>
        <% end if %>
</ul>




</center>
</div>


<br>

<div id="sec_row2" class="main_sub9">
    <div id="width">



<div style="clear:both"></div>


<div class="columnLeft">

<div class="lead_widget1">Hãng sản xuất</div>
<div class="boxDanhmuc">

                <div class=cat_list>
                  <% While ((Repeat3__numRows <> 0) AND (NOT rsHsx2.EOF)) %>
                  <a class="dell" id="hangsx" mahang="<%=(rsHsx2.Fields.Item("ID").Value)%>">☀ <%=(rsHsx2.Fields.Item("TenHang").Value)%></a><br><br>
    <% 
  Repeat3__index=Repeat3__index+1
  Repeat3__numRows=Repeat3__numRows-1
  rsHsx2.MoveNext()
Wend
%>
				
				</div>
           
</div>

<%
Dim stt
stt = 0
%>
<div class="lead_widget1">Chip</div>
  <div class="boxDanhmuc">  
    <div class=cat_list>
                   <% While ((Repeat4__numRows <> 0) AND (NOT rsChip2.EOF)) %>
                  <a class="dell" id="chip" machip="<%=stt%>">☀ <%=(rsChip2.Fields.Item("Chip").Value)%></a><br><br>       <% 
				  Stt = Stt + 1
  Repeat4__index=Repeat4__index+1
  Repeat4__numRows=Repeat4__numRows-1
  rsChip2.MoveNext()
Wend
%>

    </div>
</div>

<div class="lead_widget1">Ram</div>
  <div class="boxDanhmuc">  
    <div class=cat_list>
		<a class="dell" id="ram" ram="1">Dưới 2 GB</a><br /><br />
		<a class="dell" id="ram" ram="2">2GB - 4GB</a><br /><br />
		<a class="dell" id="ram" ram="3">4GB - 8GB</a><br /><br />
        <a class="dell" id="ram" ram="4">Trên 8GB</a><br /><br />		
    </div>
</div>

<div class="lead_widget1">Ổ cứng</div>
  <div class="boxDanhmuc">  
    <div class=cat_list>
		<a class="dell" id="hdd" hdd="1">Dưới 100 GB</a><br /><br />
		<a class="dell" id="hdd" hdd="2">100GB - 300GB</a><br /><br />
		<a class="dell" id="hdd" hdd="3">300GB - 600GB</a><br /><br />
        <a class="dell" id="hdd" hdd="4">Trên 600GB</a><br /><br />		
    </div>
</div>

<div class="lead_widget1">Giá thành</div>
  <div class="boxDanhmuc">  
    <div class=cat_list>
		<a class="dell" id="gia" gia="1">5tr-8tr</a><br /><br />
		<a class="dell" id="gia" gia="2">8tr-13tr</a><br /><br />
		<a class="dell" id="gia" gia="3">Trên 13tr</a><br /><br />
    </div>
</div>

</div>
<div id="loadhome" class="loadhome"></div>
<div class="columnSpace">&nbsp;</div>
   <div class="p_sub_list">
   	<div class="columnCenter">
    <div class="clear"></div>
<div class="isearch">
  <form id="frms" name="frms" method="post" action="" >
    
    <p align="right" style="font:italic 14px Trebuchet MS;color:red" data-tooltip="stickysearch">
      <input onblur="if(this.value=='')this.value='Tìm kiếm sản phẩm';" onfocus="if(this.value=='Tìm kiếm sản phẩm')this.value='';" type="text" value="Tìm kiếm sản phẩm" class="ip1" name="search" />&nbsp;&nbsp;&nbsp;
      <input  name="tim" type="image" src="design/search.png" class="btn1" id="tim" value="Tìm kiếm" />
    </p>

  </form>
</div>
 <div class="an"></div>
 <div class="ann"></div>
 <div class="anhome">
 <div class="columnSpace">&nbsp;</div>
<div class="columnCenter">
   <div class="p_sub_list">
     <div class="clear"></div>
     
     <div class="leadmhome">
       <div class="leadmhome_in">
         <h1>Sản phẩm mới</h1>
         
         <div class="clear"></div>
         
         <div class="clear"></div>
         <div class="lsort2">
           <select name=ssp class="selectSapxep">
             <option value="">Sắp xếp theo</option>
             <option value="1" sx=1>Mới nhất</option>
             <option value="2" sx=2>Cũ nhất</option>
             <option value="3" sx=3>Giá Thấp-Cao</option>
             <option value="4" sx=4>Giá Cao-Thấp</option>
           </select>
          </div>
         
         
        </div>
     </div>
  </div>  <% While ((Repeat1__numRows <> 0) AND (NOT rsSanpham.EOF)) %>
         <% Gia1 = CSTR(rsSanpham.Fields.Item("GiaSanPham").Value)
		Gia2 = len(Gia1)
	   Gia4(0) = Mid(Gia1, 5, 3)
	   Gia4(2) = Mid(Gia1, 1, Gia2-6)
	   Gia4(1) = Mid(Gia1, 2, 3)

	   %>
   <div class="p-item">
     <div class="framehb">
       <div class="hbimg"> <a> <img id="anhsp" src="thumb/<%=(rsSanpham.Fields.Item("Anh").Value)%>" alt="<%=(rsSanpham.Fields.Item("TenSanPham").Value)%>" class="p-img" /> </a></div>
       <div class="p-name" ><a id="dell" class="sanpham" sanpham="<%=(rsSanpham.Fields.Item("ID").Value)%>"><%=(rsSanpham.Fields.Item("TenSanPham").Value)%></a></div>
       <div class="sub3"><%=Gia4(2)%>.<%=Gia4(1)%>.<%=Gia4(0)%> VND</div>
<% if((session("user")) <> "") then %>
<% if (rsSanpham.Fields.Item("TrangThai").Value) = 1 then %>
       <a class="p_na" id="loadsp" style="cursor: pointer;" title="<%=(rsSanpham.Fields.Item("ID").Value)%>"><img src="design/line2.png"/></a>
       <% else %>
       <img src="design/line4.jpg"/>
       <% end if %>
<% end if %>
     </div>
   </div>
    <% 
  Repeat1__index=Repeat1__index+1
  Repeat1__numRows=Repeat1__numRows-1
  rsSanpham.MoveNext()
Wend
%>
</div>
    <table border="0">
      <tr>
        <td><% If MM_offset <> 0 Then %>
            <a class="pagehome" id="dell" page="<%=MM_moveFirst%>">First</a>
            <% End If ' end MM_offset <> 0 %></td>
        <td><% If MM_offset <> 0 Then %>
            <a class="pagehome" id="dell" page="<%=MM_movePrev%>">Previous</a>
            <% End If ' end MM_offset <> 0 %></td>
        <td><% If Not MM_atTotal Then %>
            <a class="pagehome" id="dell" page="<%=MM_moveNext%>">Next</a>
            <% End If ' end Not MM_atTotal %></td>
        <td><% If Not MM_atTotal Then %>
            <a class="pagehome" id="dell" page="<%=MM_moveLast%>">Last</a>
            <% End If ' end Not MM_atTotal %></td>
      </tr>
    </table>
    </div>
  
  
</div>
</div>
</div>
</div>
          <div id="mystickytooltip" class="stickytooltip"> 
            <div style="padding:5px">
            <div id="stickylogin" class="atip" style="width: auto;height:auto;">
            <div>Đăng nhập để quản lý dễ dàng hơn</div> </div>
           
            <div id="stickysearch" class="atip" style="width: auto;height:auto;">
            <div>Nhập tên sản phẩm để tìm kiếm</div> </div>
           
            <div id="stickyhsx" class="atip" style="width: auto;height:auto;">
            <div>Tìm theo hãng sản xuất</div> </div>
           
            <div id="stickygia" class="atip" style="width: auto;height:auto;">
            <div>Tìm theo Giá</div> </div>
           
            <div id="stickytin" class="atip" style="width: auto;height:auto;">
            <div>Xem tin tức các dòng máy</div> </div>
           
            <div id="stickyhome" class="atip" style="width: auto;height:auto;">
            <div>Click để trở về trang chủ</div> </div>

            <div id="stickyh" class="atip" style="width: auto;height:auto;">
            <div class="show"></div> </div>
            </div>
            </div>
<script type='text/javascript'>window._sbzq||function(e){e._sbzq=[];var t=e._sbzq;t.push(["_setAccount",4356]);var n=e.location.protocol=="https:"?"https:":"http:";var r=document.createElement("script");r.type="text/javascript";r.async=true;r.src=n+"//static.subiz.com/public/js/loader.js";var i=document.getElementsByTagName("script")[0];i.parentNode.insertBefore(r,i)}(window);</script>
</body>
</html> 
<%
rsHsx.Close()
Set rsHsx = Nothing
%>
<%
rsHsx2.Close()
Set rsHsx2 = Nothing
%>
<%
rsChip2.Close()
Set rsChip2 = Nothing
%>
<%
rsChip.Close()
Set rsChip = Nothing
%>

