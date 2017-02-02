<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
<div class="leadmhome_in">Đăng ký thành viên</div>
</head>
<body>
<form id="frmdk" name="frm2" method="post" action="" class="frm_submit" style="padding: 10;">
  <table width="619" height="556" border="0" align="center" style="padding: 10px;">
    <tr>
      <td width="135">Tên đăng nhập : </td>
      <td width="474"><input  name="tendangnhap" type="text" class="pb" id="tendangnhapreg" size="50" required="required"/><div id="loadid"></div><div class="ck" style="color:red;"></div>
	  <br />
	  <p id="tdn" style="color:#FF0000"></p>
	  </td>
    </tr>
    <tr>
      <td>Mật Khẩu: </td>
      <td><input name="matkhau" type="password" id="matkhaureg" size="50" />
	  <br />
	  <p id="matkhau"></p>
	  </td>
    </tr>
    <tr>
      <td>Xác nhận mật khẩu : </td>
      <td><input name="xacnhanmatkhau" type="password" id="rematkhaureg" size="50" /> 
      <div class="pass"  style="color: red; font-size: 13;font-family: cursive;"></div><div id="loadpass"></div>
      </td>
     
    </tr>
    <tr>
      <td>Họ và tên : </td>
      <td><input name="hoten" type="text" id="hotenreg" size="50" value="" /></td>
    </tr>
    <tr>
      <td>Giới tính : </td>
      <td><select name="gt" id="gtreg">
      <option value="1">Nam</option>
      <option value="0">Nữ</option>
      </select> </td>
    </tr>
    <tr>
      <td>Số điện thoại : </td>
      <td><input name="sodienthoai" type="text" id="sodienthoaireg" size="20" value="" /></td>
    </tr>
    <tr>
      <td>Email : </td>
      <td><input name="email" type="text" id="emailreg" size="50" value="" /></td>
    </tr>
    <tr>
      <td align="left" valign="middle">Địa chỉ : </td>
      <td align="left" valign="middle"><textarea name="diachi" cols="50" rows="5" id="diachireg"></textarea></td>
    </tr>
    <tr>
      <td colspan="2" align="center" valign="middle"><span class="xoa" id="reg">Đăng ký</span>
        <input name="reset" type="reset" id="reset" value="Reset" /></td>
    </tr>
  </table>
</form>
</body>
</html>