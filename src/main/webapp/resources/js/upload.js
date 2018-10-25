/**
 * getFileInfo()내에 선언된 변수들 설명
 * fileName : 경로나 UUID가 제외된 파일 이름
 * imgsrc : 화면상에 보여주는 썸내일 또는 file.png경로
 * getLink : 화면에서 원본 파일을 볼 수 있는 링크를 위해 작성
 * 마지막 리턴값은 정보들을 JavaScript객체로 생성해서 반환. register.jsp에서 템플릿을 이용하여 화면에 보여짐
 */

function checkImageType(fileName) {
	var pattern = /jpg|gif|png|jpeg/i;
	
	return fileName.match(pattern);
}

function getFileInfo(fullName) {
	var fileName, imgsrc, getLink;
	
	var fileLink;
	
	if(checkImageType(fullName)) {
		imgsrc = "/displayFile?fileName="+fullName;
		fileLink = fullName.substr(14);
		
		var front = fullName.substr(0, 12);
		var end = fullName.substr(14);
		
		getLink = "/displayFile?fileName="+front+end;
	} else {
		imgsrc = "/resources/dist/img/file.png";
		fileLink = fullName.substr(12);
		getLink = "/displayFile?fileName="+fullName;
	}
	
	fileName = fileLink.substr(fileLink.indexOf("_")+1);
	
	return {fileName:fileName, imgsrc:imgsrc, getLink:getLink, fullName:fullName};
}