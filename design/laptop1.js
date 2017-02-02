// JavaScript Document
// Hang san xuat
$(document).on('click','a.dell#hangsx',function(){
    $('#loadhome').html('<img src="design/loadhome.gif" />').show();
    $.ajax({
        url:'view/hangsanxuat.asp',
        type:'get',
        data:'id='+$(this).attr('mahang')+'&time='+new Date().getTime(),
        success:function(data){
            $('.anhome').empty();
            $('.columnCenter').empty().append(data);
            $('#loadhome').fadeOut();
        }
    })
})

$(document).on('click','a#dell.pagehsx',function(){
    $.ajax({
        url:'view/hangsanxuat.asp',
        type:'get',
        data:'id='+$(this).attr('hsx')+'&offset='+$(this).attr('page')+'&time='+new Date().getTime(),
        success:function(data){
            $('.anhome').empty();
            $('.columnCenter').hide().empty().append(data).fadeIn();
        }
    })
})
//

// Hdd
$(document).on('click','a.dell#hdd',function(){
    $('#loadhome').html('<img src="design/loadhome.gif" />').show();
    $.ajax({
        url:'view/hdd.asp',
        type:'get',
        data:'id='+$(this).attr('hdd')+'&time='+new Date().getTime(),
        success:function(data){
            $('.anhome').empty();
            $('.columnCenter').empty().append(data);
            $('#loadhome').fadeOut();
        }
    })
})

$(document).on('click','a#dell.pagehdd',function(){
    $.ajax({
        url:'view/hdd.asp',
        type:'get',
        data:'id='+$(this).attr('hdd')+'&offset='+$(this).attr('page')+'&time='+new Date().getTime(),
        success:function(data){
            $('.anhome').empty();
            $('.columnCenter').hide().empty().append(data).fadeIn();
        }
    })
})
//

// Gia thanh
$(document).on('click','a.dell#gia',function(){
    $('#loadhome').html('<img src="design/loadhome.gif" />').show();
    $.ajax({
        url:'view/gia.asp',
        type:'get',
        data:'id='+$(this).attr('gia')+'&time='+new Date().getTime(),
        success:function(data){
            $('.anhome').empty();
            $('.columnCenter').empty().append(data);
            $('#loadhome').fadeOut();
        }
    })
})

$(document).on('click','a#dell.pagegia',function(){
    $.ajax({
        url:'view/gia.asp',
        type:'get',
        data:'id='+$(this).attr('gia')+'&offset='+$(this).attr('page')+'&time='+new Date().getTime(),
        success:function(data){
            $('.anhome').empty();
            $('.columnCenter').hide().empty().append(data).fadeIn();
        }
    })
})
//

// Chip
$(document).on('click','a.dell#chip',function(){
    $('#loadhome').html('<img src="design/loadhome.gif" />').show();
    $.ajax({
        url:'view/chip.asp',
        type:'get',
        data:'id='+$(this).attr('machip')+'&time='+new Date().getTime(),
        success:function(data){
            $('.anhome').empty();
            $('.columnCenter').empty().append(data);
            $('#loadhome').fadeOut();
        }
    })
})

$(document).on('click','a#dell.pagechip',function(){
    $.ajax({
        url:'view/chip.asp',
        type:'get',
        data:'id='+$(this).attr('chip')+'&offset='+$(this).attr('page')+'&time='+new Date().getTime(),
        success:function(data){
            $('.anhome').empty();
            $('.columnCenter').hide().empty().append(data).fadeIn();
        }
    })
})
//

// Ram
$(document).on('click','a.dell#ram',function(){
    $('#loadhome').html('<img src="design/loadhome.gif" />').show();
    $.ajax({
        url:'view/ram.asp',
        type:'get',
        data:'id='+$(this).attr('ram')+'&time='+new Date().getTime(),
        success:function(data){
            $('.anhome').empty();
            $('.columnCenter').empty().append(data);
            $('#loadhome').fadeOut();
        }
    })
})

$(document).on('click','a#dell.pageram',function(){
    $.ajax({
        url:'view/ram.asp',
        type:'get',
        data:'id='+$(this).attr('ram')+'&offset='+$(this).attr('page')+'&time='+new Date().getTime(),
        success:function(data){
            $('.anhome').empty();
            $('.columnCenter').hide().empty().append(data).fadeIn();
        }
    })
})
//

// Home
$(document).on('click','a.dell#home',function(){
    $('#loadhome').html('<img src="design/loadhome.gif" />').show();
            $('.anhome').empty();
            $('.columnCenter').empty().load('view/home.asp?time='+new Date().getTime());
            $('#loadhome').fadeOut('slow');
})

$(document).on('click','a#dell.pagehome',function(){
    $.ajax({
        url:'view/home.asp',
        type:'get',
        data:'offset='+$(this).attr('page')+'&time='+new Date().getTime(),
        success:function(data){
            $('.anhome').empty();
            $('.columnCenter').hide().empty().append(data).fadeIn();
        }
    })
})
//

// Thong tin san pham
$(document).on('click','a#dell.sanpham',function(){
    $.ajax({
        url:'view/sanpham.asp',
        type:'get',
        data:'id='+$(this).attr('sanpham')+'&time='+new Date().getTime(),
        success:function(data){
            $('.anhome').empty();
            $('.columnCenter').hide().empty().append(data).fadeIn();
        }
    })
})
//

// Sap xep
$(document).on('change','select.selectSapxep',function(){
    $.ajax({
        url:'view/sapxep.asp',
        type:'get',
        data:'id='+$(this).val()+'&time='+new Date().getTime(),
        success:function(ok){
            $('.anhome').hide();
            $('.isearch').hide();
            $('.count').hide();
            $('.ann').empty();
            $('.ann').html(ok).hide();
            $('.ann').slideDown('fast');
            
        }
    })
})

$(document).on('click','a#dell.pagesx',function(){
    $.ajax({
        url:'view/sapxep.asp',
        type:'get',
        data:'id='+$(this).attr('sx')+'&offset='+$(this).attr('page')+'&time='+new Date().getTime(),
        success:function(data){
            $('.anhome').empty();
            $('.columnCenter').hide().empty().append(data).fadeIn();
        }
    })
})
//

// Tim  kiem
$(document).on('keyup','input.ip1',function(){
        if($(this).val()==""){
    $('.an').fadeOut('fast');
    $('.anhome').show();
    return false;
    }
    else{
        $('.anhome').hide();
    }
        $.ajax({
            url:'view/timkiem.asp',
            type:'get',
            data:'search='+$(this).val()+'&time='+new Date().getTime(),
            success:function(ok){
                $('.an').hide();
                $('.an').empty();
                 $('.an').html(ok);
                 $('.an').show();
            }
        })
    })
	
$(document).on('click','a#dell.pagetk',function(){
    $.ajax({
        url:'view/timkiem.asp',
        type:'get',
        data:'search='+$(this).attr('tk')+'&offset='+$(this).attr('page')+'&time='+new Date().getTime(),
        success:function(ok){
                $('.an').hide();
                $('.an').empty();
                 $('.an').html(ok);
                 $('.an').show();
        }
    })
})
//

// Kiem tra User dang ky
$(document).on('change','.pb#tendangnhapreg',function(){
         $("#loadid").html("<img src='design/loading.gif'/>").fadeIn('fast');
        $.ajax({
            url:"view/kiemtraid.asp",
            type:"get",
            datatype:"text",
            data:"id="+$(this).val()+"&time="+new Date().getTime(),
            success:function(xog){
                $(".ck").html(xog);
                $("#loadid").fadeOut("fast");
            }
        })
    })
//

// Kiem tra mat khau dang ky
    $(document).on('blur','#rematkhaureg',function(){
        $("#loadpass").html("<img src='design/loading.gif'/>").fadeIn("fast");
        $.ajax({
            url:"view/kiemtraps.asp",
            type:"get",
            data:"pass="+$("#matkhaureg").val()+"&rpass="+$("#rematkhaureg").val()+"&time="+new Date().getTime(),
            success:function(ok)
            {
                $(".pass").html(ok);
                $("#loadpass").fadeOut("fast");
            }
        })
    })
//

// Trang dang ky
$(document).on('click','a.dell#dangky',function(){
    $('.anhome').empty();
    $('.columnCenter').css({'width':'50','height':'40'});
    $('.columnCenter').animate({width:800},'slow').animate({height:577},'slow');
    $('.columnCenter').empty().load('view/dangky.asp?time='+new Date().getTime());

})
//


$(document).on('click','a.dell#tintuc',function(){
	    $('#loadhome').html('<img src="design/loadhome.gif" />').show();
    $('.anhome').empty();
    $('#loadhome').fadeOut();
    $('.columnCenter').empty().load('view/tintuc.asp?time='+new Date().getTime());

})


$(document).on('click','.xoa#reg',function(){

var checkmail=/^[A-Za-z][A-Za-z0-9]{4,20}@[A-Za-z]+\.[A-Za-z]{2,4}(.[A-Za-z]{2,4})*$/;
var checkdt=/^[0-9]{10,11}$/;
var checkid=/^[A-Za-z0-9]{6,12}$/;
var checkpass=/^[A-Za-z0-9]{6,12}$/;
var checksl=/^[0-9]{1,2}$/;

    if($('input#hotenreg').val().trim()==''){
        alert('Bạn chưa nhập họ tên');
		$('input#hotenreg').focus();
        return false;
    }
    if($('input#emailreg').val().trim()==''){
        alert('Bạn chưa nhập email');
		$('input#emailreg').focus();
        return false;
    }
    if($('input#matkhaureg').val().trim()==''){
        alert('Bạn chưa nhập mật khẩu');
		$('input#matkhaureg').focus();
        return false;
    }
    if($('input#tendangnhapreg').val().trim()==''){
        alert('Bạn chưa nhập tên đăng nhập');
		$('input#tendangnhapreg').focus();
        return false;
    }
	if($('input#sodienthoaireg').val().trim()==''){
        alert('Bạn chưa nhập số điện thoại');
		$('input#sodienthoaireg').focus();
        return false;
    }
	if($('textarea#diachireg').val().trim()==''){
        alert('Bạn chưa nhập địa chỉ');
		$('textarea#diachireg').focus();
        return false;
    }
    if(!checkmail.test(document.frm2.email.value)){
        alert('Bạn nhập sai địa chỉ email');
        return false;
	}
    if(!checkdt.test(document.frm2.sodienthoai.value)){
    alert('Bạn nhập sai số điện thoại');
    return false;
    }
    if(!checkid.test(document.frm2.tendangnhap.value)){
        alert('Tên đăng nhập không hợp lệ');
        return false;
    }
    if(!checkpass.test(document.frm2.matkhau.value)){
        alert('Mật khẩu không hợp lệ');
        return false;
    }
    if($('input#matkhaureg').val()!=$('input#rematkhaureg').val()){
        alert('Mật khẩu không trùng khớp');
        return false;
    }	
$('#loadhome').html('<img src="design/loadhome.gif" />').show();
var hoten = $('input#hotenreg').val();
var matkhau = $('input#matkhaureg').val();
var tendangnhap = $('input#tendangnhapreg').val();
var diachi = $('textarea#diachireg').val();
var email = $('input#emailreg').val();
var time = new Date().getTime();
var gt = $('select#gtreg').val();
var sodienthoai = $('input#sodienthoaireg').val();
    $.ajax({
        url:'view/xulydangky.asp',
        type:'get',
        data: {hoten:hoten, matkhau:matkhau, tendangnhap:tendangnhap, diachi:diachi, email:email, time:time, gt:gt, sodienthoai:sodienthoai},
        success:function(ok){
            $('.anhome').empty();
            $('.columnCenter').empty().append(ok);
            $('#loadhome').fadeOut();
        }
    })
})

//

// Mua hang
$(document).ready(function(){
    $(document).on('click','.p_na',function(){
        i=$(this).attr("title");
        $('#loading').html("<img src='design/loading.gif'/>").fadeIn('fast');
        $.ajax({
            url:"view/muahang.asp",
            type:"get",
            data:"actions=mua&sp="+i+"&time="+new Date().getTime(),
            success:function(ok)
            {
                alert('Đã thêm sản phẩm vào giỏ hàng');
                $('#loading').fadeOut('fast');
            }
        })
})
//

// Xem gio hang
$(document).on('click','a.dell#giohang',function(){
    $('#loadhome').html('<img src="design/loadhome.gif" />').show();
    $('.anhome').empty();
    $('#loadhome').fadeOut();
    $('.columnCenter').empty().load('view/giohang.asp?time='+new Date().getTime());
})
//

// Xem truoc gio hang
$(document).ready(function(){
	$(document).on('mouseover','#giohang',function(){
$('#loadcount').html("<img src='design/loadcount.gif' width='50' height='50'/>").fadeIn('fast');
$('#loadshow').html("<img src='design/loading.gif'/>").fadeIn('fast');
        $.ajax({
            url:"view/giohang.asp",
            type:"get",
            data:"actions=mua&msp=3&time="+new Date().getTime(),
            success:function(ok)
            {
                $(".show").empty().append(ok);
                $('#loadshow').fadeOut('fast');
                $('#loadcount').fadeOut('fast');
            }
        })
	})
})	
//

// Xoa san pham trong gio hang
$(document).on('click','.xoa#del',function(){
    $('#loadupdat').html("<img src='design/loading.gif'/>").fadeIn('fast');
    $.ajax({
        url:"view/muahang.asp",
        type:"get",
        data:"actions=xoa&time="+new Date().getTime()+"&sp="+$(this).attr('del'),
        success:function(ok){
            $('#an2').empty().append(ok).hide().slideDown('fast');
            $('#loadupdat').slideToggle('slow');
            $(".columnCenter").empty().load('view/muahang.asp?time='+new Date().getTime());
        }
    })
})
//

// Xoa gio hang
    $(document).on('click','#sub',function(){
        if(confirm('Bạn muốn xóa toàn bộ sản phẩm trong giỏ hàng?')){

        $('#loadupdate').html("<img src='design/loading.gif'/>").fadeIn('fast');
        $.ajax({
            url:"view/muahang.asp",
            type:"get",
            data:"actions=xoahet&times="+new Date().getTime(),
            success:function(ok)
            {
                $(".xoahet").load('view/muahang.asp');
                $("#an2").hide('slow');
                $(".xoa").slideToggle('slow');
                $('.show').empty().load('view/giohang.asp');
                $('#loadupdate').fadeOut('fast');
            }

        })
        }
    })
//

// Thanh toan
$(document).on('click','#thanhtoan',function(){
        $('.thanhtoan').load('view/thanhtoan.asp?time='+new Date().getTime()).fadeIn('slow');
        $('#angiohang').slideUp('slow');

      })
//

// Login
    var overlay = $('.overlay');
    var login = $('.login');
    var body = $('body');
    $(document).on('click','.login-button',function(e){
        e.preventDefault();
     
        overlay.slideDown(500,function(){
            login.fadeIn(1000);
            $('#tendangnhap').focus();
        })
    })

    $(document).on('click','.close',function(e){
        e.preventDefault();
        login.slideUp(500,function(){
            overlay.slideUp(500);
            body.css({'overflow':'visible'});
        })
    })
//

// Dang nhap
$(document).on('click','.loginsubmit',function(){
     $('.cklogin').empty();
    if($('input#tendangnhap').val().trim()==''){
        $('<br/><span class="cklogin" style="color:red">Tên đăng nhập không được để trống</span>').insertAfter('#tendangnhap');
        return false;
    }
    if($('input#matkhau').val().trim()==''){
        $('<br/><span class="ckpass" style="color:red">Mật khẩu không được để trống</span>').insertAfter('#matkhau');
        return false;
    }
    $.ajax({
        url:'view/dangnhap.asp',
        type:'get',
        data:'tendangnhap='+$('#tendangnhap').val()+'&matkhau='+$('#matkhau').val()+'&time='+new Date().getTime(),
        success:function(data){
            $('.showlogin').html(data);
            if($('.tt').attr('tt')==1){
                $('#loadbanner').empty().load('view/loadbanner.asp?time='+new Date().getTime());
                login.slideUp(500,function(){
                overlay.slideUp(500);
                body.css({'overflow':'visible'});
 $('.removelg').fadeOut();
                
        })  
               
            }  
        }
    })
})
//

// Dang xuat
$(document).on('click','.logout',function(){
    $('#loadbanner').hide().load('view/dangxuat.asp?time='+new Date().getTime());
    $('#loadbanner').empty().load('view/loadbanner.asp?time='+new Date().getTime()).fadeIn();
    $('.removelg').fadeIn();
   
})
//

// Thong tin thanh vien
$(document).on('click','.user#dell',function(){
    $.ajax({
        url:'view/thongtinthanhvien.asp',
        type:'get',
        data:'user='+$(this).attr('user')+'&time='+new Date().getTime(),
        success:function(data){
            $('.anhome').empty();
            $('.columnCenter').hide().empty().append(data).slideDown();
        }
    })
})
//

// Sua thong tin ca nhan
$(document).on('click','#editus',function(){
    $.ajax({
        url:'view/suathongtin.asp',
        type:'get',
		contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
        data:'user='+$(this).attr('user')+'&time='+new Date().getTime(),
        success:function(data){
            $('.anxem').hide().empty().append(data).slideDown();
        }
    })
})

$(document).on('click','#xong',function(){
    if($('#hoten').val().trim()=="" || $('#dc').val().trim()=="" || $('#mail').val().trim()=="" || $('#sdt').val().trim()==""){
        alert('Bạn cần nhập đủ thông tin');
        return false; }
	var hoten = $('#hoten').val();
	var dc = $('#dc').val();
	var mail = $('#mail').val();
	var sdt = $('#sdt').val();
	var gt = $('#gt').val();
	var time = new Date().getTime();
    $.ajax({
        url:'view/suathongtin.asp?time='+new Date().getTime(),
        type:'get',
		data: {hoten:hoten, dc:dc, mail:mail, sdt:sdt, gt:gt, time:time},
        success:function(data){
			$('.anxem').hide().empty().append(data).slideDown('slow').load('view/thongtinthanhvien.asp?time='+new Date().getTime());
			
       }
    })
})
//

// Doi mat khau
var checkps=/^[A-Za-z0-9]{6,12}$/;
$(document).on('click','.dell#changepass',function(){
    $('.anhome').empty();
    $('.columnCenter').hide().slideDown().empty().load('view/doimatkhau.asp?time='+new Date().getTime());
})

$(document).on('click','.xoa#change',function(){
    if($('#mku').val().trim()==''){
        alert('Bạn chưa nhập mật khẩu cũ');
        return false;
    }
    if($('#mkun').val().trim()==''){
        alert('Bạn chưa nhập mật khẩu mới');
        return false;
    }
    if($('#rmku').val().trim()!=$('#mkun').val().trim()){
        alert('Mật khẩu không trùng nhau');
        return false;
    }
	if(!checkps.test(document.form1.mkun.value)){
        alert('Mật khẩu mới không hợp lệ');
        return false;
    }
    $.ajax({
        url:'view/doimatkhau.asp',
        type:'get',
        data:'mku='+$('#mku').val()+'&mkun='+$('#mkun').val()+'&rmku='+$('#rmku').val()+'&change=1&time='+new Date().getTime(),
        success:function(data){
            $('.anhome').empty();
            $('.columnCenter').empty().append(data);
        }
    })
})
//

// Thanh toan
$(document).on('click','.xoa#guidon',function(){
var checkmail=/^[A-Za-z][A-Za-z0-9]{4,20}@[A-Za-z]+\.[A-Za-z]{2,4}(.[A-Za-z]{2,4})*$/;
var checkdt=/^[0-9]{10,11}$/;
var checkht=/^[A-Za-z]{0,100}$/;
var checkpass=/^[A-Za-z0-9]{6,12}$/;
var checksl=/^[0-9]{1,2}$/;

         if($("#hoten").val().trim()=="" || $("#diachi").val().trim()=="" || $("#dienthoai").val().trim()=="" || $("#mail").val().trim()=="" || $("#diachi").val().trim()=="" || $("#ngaygiao").val().trim()==""){
         alert('Vui lòng nhập các thông tin bắt buộc');
         return false;
		 }
		 if(!checkmail.test($("#mail").val())){
            alert('Vui lòng nhập đúng địa chỉ email');
            return false;
         }
		 if(!checkdt.test($("#dienthoai").val())){
            alert('Vui lòng nhập đúng số điện thoại');
            return false;
         }
       var h=$('#ngaygiao').val();
       var k=$('span#datenow').attr('date');
        if(Date.parse(h)<Date.parse(k) || h==''){
            alert('Vui lòng nhập lại ngày giao hàng');
            return false;
        }
	var hoten = $("#hoten").val();
	var diachi = $("textarea#diachi").val();
	var dienthoai = $("#dienthoai").val();
	var mail = $("#mail").val();
	var ngaygiao = $("#ngaygiao").val();
	var yc = $("#yc").val();
	var gt = $("#gt").val();
	var user = $('.mak').attr('user');
	var time = new Date().getTime();
    $.ajax({
        url:'view/hoadon.asp?time='+Math.random(),
        type:'get',
        data: {time: time, hoten:hoten, diachi: diachi, dienthoai: dienthoai, mail: mail, ngaygiao : ngaygiao, yc: yc, gt: gt, user: user},
        success:function(thanhcong){
            $("#frmdel").slideUp('slow');
            $(".guixong").hide().html(thanhcong);
            $('.guixong').slideDown();
            $('.anttk').slideUp();
            }
        })
    })
//

// Binh luan
$(document).on('click','a.dell#binhluan',function(){
    $('.binhluan').load('view/guibinhluan.asp?time='+new Date().getTime()+'&id='+$(this).attr('binhluan')).fadeIn('slow');
        $('#ansanpham').slideUp('slow');
})

$(document).on('click','.xoa#bl',function(){
    if($('textarea#nd').val().trim()==""){
        alert('Bạn cần nhập đủ thông tin');
        return false; }
	var nd = $('textarea#nd').val();
	var khid = $('#khid').val();
	var spid = $('#spid').val();
	var role = $('#role').val();
	var time = new Date().getTime();
    $.ajax({
        url:'view/binhluan.asp?time='+new Date().getTime(),
        type:'get',
		data: {nd:nd, time:time, khid:khid, spid:spid, role:role},
        success:function(data){
			$('.binhluan').hide();
			$('.anxem').hide().empty().append(data).slideDown('slow').load('view/home.asp?time='+new Date().getTime());
			
       }
    })
})
})



// Thong tin tin tuc
$(document).on('click','a#dell.tintuc',function(){
    $.ajax({
        url:'view/thongtintintuc.asp',
        type:'get',
        data:'id='+$(this).attr('tin')+'&time='+new Date().getTime(),
        success:function(data){
            $('.anhome').empty();
            $('.columnCenter').hide().empty().append(data).fadeIn();
        }
    })
})
//