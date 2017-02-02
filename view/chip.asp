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
Dim Repeat4__numRows
Dim Repeat4__index
Dim Stt
Dim Chip
Stt = 0
Repeat4__numRows = -1
Repeat4__index = 0
rsChip_numRows = rsChip_numRows + Repeat4__numRows
%>
                   <% While ((Repeat4__numRows <> 0) AND (NOT rsChip.EOF))
                  if(Stt = CInt(rsSanpham__MMColParam)) then 
                  Chip = (rsChip.Fields.Item("Chip").Value)
                  end if %>
       <% 
	   Stt = Stt + 1
  Repeat4__index=Repeat4__index+1
  Repeat4__numRows=Repeat4__numRows-1
  rsChip.MoveNext()
Wend
%>


<%
Dim rsSanpham
Dim rsSanpham_cmd
Dim rsSanpham_numRows

Set rsSanpham_cmd = Server.CreateObject ("ADODB.Command")
rsSanpham_cmd.ActiveConnection = MM_cn_STRING
rsSanpham_cmd.CommandText = "SELECT * FROM dbo.tbSanPham WHERE Chip = ?" 
rsSanpham_cmd.Prepared = true
rsSanpham_cmd.Parameters.Append rsSanpham_cmd.CreateParameter("param1", 200,1,50, Chip) ' adDouble

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
<%
Dim Gia1
Dim Gia2
Dim Gia4(8)
%><div class="isearch">
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
         <h1>Phân loại Chip</h1>
         
         <div class="clear"></div>
        </div>
     </div>
  </div>
<% if((MM_rsCount) = 0) then %>
   <div class="no-item">
Không có sản phẩm thuộc loại chip này
</div>
<% end if %>
  <% While ((Repeat1__numRows <> 0) AND (NOT rsSanpham.EOF)) %>
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
</div>
<div>
<table border="0">
  <tr>
    <td><% If MM_offset <> 0 Then %>
        <a class="pagechip" id="dell" page="<%=MM_moveFirst%>" chip="<%=Request.QueryString("ID")%>">First</a>
        <% End If ' end MM_offset <> 0 %></td>
    <td><% If MM_offset <> 0 Then %>
        <a class="pagechip" id="dell" page="<%=MM_movePrev%>" chip="<%=Request.QueryString("ID")%>">Previous</a>
        <% End If ' end MM_offset <> 0 %></td>
    <td><% If Not MM_atTotal Then %>
        <a class="pagechip" id="dell" page="<%=MM_moveNext%>" chip="<%=Request.QueryString("ID")%>">Next</a>
        <% End If ' end Not MM_atTotal %></td>
    <td><% If Not MM_atTotal Then %>
        <a class="pagechip" id="dell" page="<%=MM_moveLast%>" chip="<%=Request.QueryString("ID")%>">Last</a>
        <% End If ' end Not MM_atTotal %></td>
  </tr>
</table>
</div>
<%
rsSanpham.Close()
Set rsSanpham = Nothing
%>
