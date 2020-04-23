<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모의 면접 결과 보기</title>
	<script src="<c:url value="/resources/js/jquery-3.4.1.min.js"/>"></script>
<script type="text/javascript">
window.AudioContext = window.AudioContext || window.webkitAudioContext;
var context = new window.AudioContext();
var source;
function playSound(arraybuffer) {
    context.decodeAudioData(arraybuffer, function (buf) {
        source = context.createBufferSource();
        source.connect(context.destination);
        source.buffer = buf;
        source.start(0);
    });
}

function handleFileSelect(evt) {
    var files = evt.target.files; // FileList object
    playFile(files[0]);
}

function playFile(file) {
    var freader = new FileReader();

    freader.onload = function (e) {
        console.log(e.target.result);
        playSound(e.target.result);
    };
    freader.readAsArrayBuffer(file);
}

player = document.getElementById('player');
document.getElementById('files').addEventListener('change', handleFileSelect, false);
document.getElementById('play').onclick = function () {
    player.play();
};
</script>
</head>
<body>
<input id="files" type="file" id="files" name="files[]" multiple />
<input id="play" type="button" value="play" />
</body>
</html>