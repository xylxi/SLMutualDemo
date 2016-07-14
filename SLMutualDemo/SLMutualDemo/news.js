window.onload=function() {
    var allImgs = document.getElementsByTagName("img")
    for (var i = 0 ; i < allImgs.length ; i++) {
        var img = allImgs[i];
        img.onclick=function() {
            
            window.location.href = "location://method:" + img.offsetLeft + "_" + img.offsetTop + "_" + img.offsetWidth + "_" + img.offsetHeight
        }
    }
}