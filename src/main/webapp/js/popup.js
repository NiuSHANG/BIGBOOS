function initPopup(message, classes, duration) {
    let popup = document.createElement('div');
    popup.innerText = message;
    popup.style.width = 'calc(100vw - 2rem)';
    popup.style.height = '2rem';
    popup.style.lineHeight = '2rem';
    popup.style.textAlign = 'center';
    popup.style.background = '#CCC';
    popup.style.borderColor = '#888';
    popup.style.borderRadius = '4px';
    popup.style.userSelect = 'none';
    popup.style.msUserSelect = 'none';
    popup.style.mozUserSelect = 'none';
    popup.style.webkitUserSelect = 'none';
    popup.style.transition = '1s';
    popup.style.position = 'fixed';
    popup.style.top = '-3rem';
    popup.style.left = '1rem';
    popup.style.cursor = 'pointer';
    popup.classList.add(classes);
    document.body.appendChild(popup);

    setTimeout(() => {
        popup.style.top = '1rem';
        popup.addEventListener('click', () => popup.style.top = '-3rem');
        setTimeout(() => {
            popup.style.top = '-3rem';
            setTimeout(() => document.body.removeChild(popup), 1000);
        }, 1000 + duration ? duration : 5000);
    }, 100);
}
