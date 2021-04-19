<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../includes/header.jsp"%>


<div class="regModal modal" tabindex="-1">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">Modal title</h5>
			</div>
			<div class="modal-body">
				<p>수정이 완료되었습니다.</p>
			</div>
			<div class="modal-footer">
				<button type="button" class="regCommit btn btn-primary">확인</button>
			</div>
		</div>
	</div>
</div>

<div class="content">

	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card card-profile">
					<div class="card-avatar">
						<a href="javascript:;"> <img class="imgLogo modal-img" style="width: 130px; height: 130px"
							src="/admin/common/logo/view?link=${store.sno }/${store.logoImg}" />
						</a>
					</div>
					<div class="card-body" style="text-align: left;">
					 <form class="regStore" action="/admin/store/modify" method="post" accept-charset="UTF-8"> 
						<div class="row" style="text-align: center;">
							<div class="col-md-4">
							</div>
							<div class="col-md-4">
							<label class="bmd-label-floating">매장명</label> <input
										type="text" class="form-control" name='sname'  value="${store.sname}" />
							</div>
							<div class="col-md-4">
							</div>
						</div>
						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<label class="bmd-label-floating">MID</label> <input
										type="text" class="form-control" name='mid' value="${mid}" readonly="readonly"/>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label class="bmd-label-floating">CATEGORY</label> <input
										type="text" class="form-control" name='category' value="${store.category}">
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12">
								<div class="form-group bmd-form-group is-focused">
									<label class="bmd-label-floating">LogoImg</label>

								</div>
								<div style="margin-bottom: 10px">
									<input type="file" name="logoImg" class="form-control" data-fileName="${store.logoImg }" id="inputGroupFile02"/>
								</div>
								<div class="fileThumb"></div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12">
								<div class="addr form-group">
									<label class="bmd-label-floating">Address</label> <input
										type="text" onClick="goPopup();" class="form-control"
										id="roadFullAddr" name="address" value="${store.address}">
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<input type="hidden" name="lat" class="lat form-control" value="${store.lat}">
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<input type="hidden" name="lng" class="lng form-control" value="${store.lng}">
								</div>
							</div>
						</div>
						
						<div class="col-md-6">
								<div class="form-group">
								<input type="hidden" class="form-control" name='sno' value="${store.sno}" readonly="readonly"/>
								</div>
							</div>
						<div class="row">
							<div class="col-md-12">
								<div class="form-group bmd-form-group is-focused">
									<label class="bmd-label-floating">매장이미지</label>

								</div>
								<div style="margin-bottom: 10px">
									<input type="file" name="storeImg" class="form-control" id="inputGroupFile02"  multiple="multiple"/>
								</div>
								<div class="fileThumb"></div>
							</div>
						</div>
						<div class="row storeThumb">
						<c:forEach items="${storeImg }" var="file">
							<div class='col-md-2 delFile${file.suuid}'>
							 <ul>
								 <li id='li${file.suuid}' data-suuid='${file.suuid}' data-sfileName='${file.sfileName}' data-suploadPath='${file.suploadPath}'>${file.sfileName}
									 <img src='/admin/common/store/Imgview?link=${store.sno}/s_${file.suuid}_${file.sfileName}'/>
										 <button class='btn btn-round btn-danger' style = 'padding: 5px;' onclick='delTempImg(event, "${file.suuid}")'>삭제</button>
								 </li>
							 </ul>
							  </div>
						</c:forEach>	  
						</div>
							
						<a href='' class="regBtn btn btn-primary btn-round">수정</a>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a992392fec7fc62c30d19315b7c1a5e1&libraries=services"></script>
<script>

const mid = document.querySelector("input[name='mid']").value
const arr = []
const InsertArr = []



// delete



//fileUpload
const csrfTokenValue = "${_csrf.token}"

document.querySelector("input[name='logoImg']").addEventListener("change" , function(e){

	  	e.preventDefault()
	    const fd = new FormData() 
	    const files = e.target.files
	    fd.append("files", files[0])
	    fd.append("value", e.target.name)
	    console.log(fd)
	    console.log(csrfTokenValue);
	    service.sendUpload(fd, csrfTokenValue).then(result => {
	    	console.dir(result[0])
	    	e.target.setAttribute("data-fileName" , result[0].sfileName)
	    }) 
	    
	    service.sendUploadThumb(fd, csrfTokenValue)
	   
} , false)
	
// fileUploadStoreImgView
		document.querySelector("input[name='storeImg']").addEventListener("change", function(e){
		
		e.preventDefault()
		
		const formdata = new FormData()
		
		const files = document.querySelector("input[name='storeImg']").files
		
		console.log(files)
		
		const storeThumb = document.querySelector(".storeThumb")
		
		for(var i = 0; i < files.length ; i++){
			
			formdata.append("uploadFile", files[i])
			
		}
		
		service.storeUpload(formdata, csrfTokenValue).then(jsonObj => 
		
		 { console.log(jsonObj)
			for(var i = 0 ; i< jsonObj.length; i++){
			
			var file = jsonObj[i];
				
			storeThumb.innerHTML += "<div class='col-md-2 delFile"+file.suuid+"'> <ul><li id='li"+file.suuid+"' data-suuid='"+file.suuid+"' data-sfileName='"+file.sfileName+"' data-suploadPath='"+file.suploadPath+"'>"+file.sfileName+"<img src='/admin/common/store/view?link="+file.thumbLink+"'/><button class='btn btn-round btn-danger' style = 'padding: 5px;' onclick='delTempImg(event,"+JSON.stringify(file)+")'>삭제</button></li></ul> </div>"

		}})
		
	}, false)
	
	// tempDelete
	function delTempImg(event, file){
		
		event.preventDefault()
		console.dir(arr)
		console.log(file)
		const fileLi = document.querySelector(".delFile"+file)
		
		fileLi.remove()
		
		console.dir(arr)

		
	}
	


	// modifyPost
	 document.querySelector(".regBtn").addEventListener("click" , function(e) {
	 e.preventDefault()
	 const obj = {}
	 const form = document.querySelector(".regStore")
	 const input = document.querySelectorAll(".regStore input")

	document.querySelectorAll(".storeThumb li").forEach(e =>{
		const obj = {sfileName:e.dataset.sfilename , suuid:e.dataset.suuid , suploadPath : e.dataset.suploadpath}
		
		arr.push(obj)
	})
	
	 for (let i of input.length) {
	 obj[form.elements[i].name] = form.elements[i].value
	 }
	 obj.logoImg = document.querySelector("input[name='logoImg']").dataset.filename
	 console.log(obj)
	 obj.fileDTO = arr
	
	 service.sendRegister(obj, "/admin/store/modify", csrfTokenValue).then(result => {$(".regModal").modal("show")}) 
	
	 } , false) 

	 // regCommit
	 document.querySelector(".regCommit").addEventListener("click" , function(e){
	
	 location.href = "/admin/store/read?mid="+mid
	
	 } , false) 

	// juso
	function goPopup() {
		// 주소검색을 수행할 팝업 페이지를 호출합니다.
		// 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(https://www.juso.go.kr/addrlink/addrCoordUrl.do)를 호출하게 됩니다.
		var pop = window.open("/admin/store/jusoPopup", "pop",
				"width=570,height=420, scrollbars=yes, resizable=yes");
	}

	function jusoCallBack(roadFullAddr) {
		// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
		document.querySelector("#roadFullAddr").value = roadFullAddr;
		document.querySelector(".addr").className += 'is-focused'
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();

		// 주소로 좌표를 검색합니다
		geocoder.addressSearch(roadFullAddr, function(result, status) {

			// 정상적으로 검색이 완료됐으면 
			if (status === kakao.maps.services.Status.OK) {

				document.querySelector(".lat").value = result[0].y;
				document.querySelector(".lng").value = result[0].x;
			}
		})

	}
	

	
</script>

<%@ include file="../includes/footer.jsp"%>