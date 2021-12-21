function loadContentHome() {
    loadContentHeader();
    loadContentFooter();
}

function loadContentPessoal() {
    loadContentHeader();
    loadContentFooter();
}

function loadContentContato() {
    loadContentHeader();
    loadContentFooter();
}

function getContentLogo(){
    let imgCodeIcon = `<div class="code-icon"> <img src="https://img.icons8.com/ios/452/source-code.png" alt="Icone simbolo menor e simbolo maior"></div>`;
    let textName  = 
    `<div class="label-icon">
        <h1>
            <span>ITALO</span>
            <span style="color:#008744; letter-spacing: 15px">PIOVAN</span>
        </h1>
        <span style="letter-spacing: 20px; font-size: 1.2em"> Desenvolvedor de Software </span>
    </div>`;
    
    return imgCodeIcon + textName;
}

function loadContentHeader(){
    let logo = 
    `<div class="logo">${getContentLogo()}</div>`;
              
    let menu = 
    `<div class="menu" id="menu">
        <nav>
            <ul>
                <li><a href="Home.html">HOME</a></li>
                <li><a href="Pessoal.html">PESSOAL</a></li>
                <li><a href="Contato.html">CONTATO</a></li>
            </ul>     
        </nav>
    </div>`;
    document.getElementById("header").innerHTML = logo + menu;
}

function loadContentFooter(){
    document.getElementById("footer").innerHTML = "© 2021 - Italo Piovan - Intern Developer";
}