document.addEventListener('DOMContentLoaded', function () {
    const categories = document.querySelectorAll('.category');

    categories.forEach(function (category) {
        category.addEventListener('click', function (event) {
            const subcategories = this.querySelector('.subcategories');

            // 소분류 토글
            if (subcategories) {
                // 다른 열려있는 메뉴 닫기
                document.querySelectorAll('.subcategories.visible').forEach(function (visibleSub) {
                    if (visibleSub !== subcategories) {
                        visibleSub.classList.remove('visible');
                    }
                });

                // 현재 클릭한 메뉴의 토글
                subcategories.classList.toggle('visible');
            }

            // 클릭 이벤트가 document로 전파되지 않도록 중단
            event.stopPropagation();
        });
    });

    // 문서 전체를 클릭했을 때 드롭다운 메뉴 닫기
    document.addEventListener('click', function () {
        // 열려 있는 모든 소분류 닫기
        document.querySelectorAll('.subcategories.visible').forEach(function (subcategory) {
            subcategory.classList.remove('visible');
        });
    });
});

function hide(){
	const rightDiv = document.getElementById("right");
	rightDiv.style.display = "none"; 
}

function goStep2(listItem) {
			    // 1. 클릭된 li 태그에서 data-name 값 읽기
			    const name = listItem.getAttribute('data-name');
			    if (!name) {
			        alert("선택된 항목이 없습니다.");
			        return;
			    }
			     // 2. 비상연락처 값 읽기
			    const front = document.getElementById('front').value.trim();
			    const middle = document.getElementById('middle').value.trim();
			    const back = document.getElementById('back').value.trim();
			
			    const patFront = document.getElementById('pat_fornt').value.trim();
			    const patMiddle = document.getElementById('pat_middle').value.trim();
			    const patBack = document.getElementById('pat_back').value.trim();
			
			    let contact = "";
			    if (front || middle || back) {
			        contact = front + "-" + middle + "-" + back;
			    } else {
			        contact = patFront + "-" + patMiddle + "-" + patBack;
			    }
			
			    // 3. location.href에 비상연락처 추가
			    location.href = "step2.do?name=" + encodeURIComponent(name) + "&contact=" + encodeURIComponent(contact);
			}




