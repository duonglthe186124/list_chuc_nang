<%-- 
    Document   : home_page
    Created on : Sep 25, 2025, 8:00:31 AM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width,initial-scale=1" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/home.css" />
        <title>Stock Phone Management</title>
    </head>
    <body>
        <!-- NAVBAR -->
    <nav class="nav">
        <div class="brand">
            <a href="home.html">
                <div class="logo" aria-hidden>
                    <!-- simple monogram -->
                    <svg
                        width="26"
                        height="26"
                        viewBox="0 0 24 24"
                        fill="none"
                        xmlns="http://www.w3.org/2000/svg"
                        >
                        <rect
                            x="2"
                            y="2"
                            width="20"
                            height="20"
                            rx="4"
                            fill="black"
                            opacity="0.12"
                            />
                        <path
                            d="M6 16V8h4l4 4v4"
                            stroke="#06121a"
                            stroke-width="1.2"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            />
                    </svg>
                </div>
            </a>
            <div>
                <h1>StockPhone</h1>
                <p>Phone Stock Management</p>
            </div>
        </div>

        <div class="navlinks" role="navigation" aria-label="Primary">
            <a href="/">Home</a>
            <a href="${pageContext.request.contextPath}/products">Products</a>
            <a href="/about">About</a>
            <a href="/policy">Policy</a>
            <a href="/reports">Reports</a>
        </div>

        <div class="cta">
            <button class="icon-btn" title="Tìm kiếm" aria-label="Tìm kiếm">
                <!-- search icon -->
                <svg
                    width="18"
                    height="18"
                    viewBox="0 0 24 24"
                    fill="none"
                    xmlns="http://www.w3.org/2000/svg"
                    >
                    <path
                        d="M21 21l-4.35-4.35"
                        stroke="currentColor"
                        stroke-width="1.4"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        />
                    <circle
                        cx="11"
                        cy="11"
                        r="6"
                        stroke="currentColor"
                        stroke-width="1.4"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        />
                </svg>
            </button>
            
            <a
                class="icon-btn"
                href="${pageContext.request.contextPath}/login"
                title="Đăng nhập"
                aria-label="Đăng nhập"
                >
                <!-- user icon -->
                <svg
                    width="18"
                    height="18"
                    viewBox="0 0 24 24"
                    fill="none"
                    xmlns="http://www.w3.org/2000/svg"
                    >
                    <path
                        d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"
                        stroke="currentColor"
                        stroke-width="1.4"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        />
                    <circle
                        cx="12"
                        cy="7"
                        r="4"
                        stroke="currentColor"
                        stroke-width="1.4"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        />
                </svg>
            </a>

            <button
                class="hamburger"
                id="hamburger"
                aria-controls="mobileMenu"
                aria-expanded="false"
                >
                <svg
                    width="26"
                    height="26"
                    viewBox="0 0 24 24"
                    fill="none"
                    xmlns="http://www.w3.org/2000/svg"
                    >
                    <path
                        d="M4 7h16M4 12h16M4 17h16"
                        stroke="currentColor"
                        stroke-width="1.6"
                        stroke-linecap="round"
                        />
                </svg>
            </button>
        </div>
    </nav>

    <!-- MOBILE MENU (hidden on desktop) -->
    <div class="mobile-menu container" id="mobileMenu" hidden>
        <a href="/">Home</a>
        <a href="/products">Products</a>
        <a href="/products/new">Add product</a>
        <a href="/about">About</a>
        <a href="/policy">Policy</a>
        <a href="/reports">Reports</a>
        <div style="display: flex; gap: 8px; margin-top: 8px">
            <a href="/login" class="icon-btn" style="width: auto; padding: 8px 12px"
               >Đăng nhập</a
            >
        </div>
    </div>

    <!-- sample page content -->
    <main
        class="container"
        style="max-width: 1100px; margin: auto auto; padding: 0 20px"
        >
        <section style="padding: 24px; background: #f9fafb; border-radius: 12px">
            <h2 style="margin-top: 0">Demo trang chính</h2>
            <p style="color: var(--muted)">
                Phần nội dung nằm ở đây. Thanh navbar bên trên phục vụ điều hướng đến
                chức năng quản lý kho, sản phẩm, báo cáo, và các chính sách. Lorem
                ipsum dolor, sit amet consectetur adipisicing elit. Ratione nemo fuga
                quos, esse rerum ullam harum quibusdam, quidem eum voluptate minima
                animi laudantium alias dignissimos eius maxime sequi, repudiandae
                consectetur. Culpa, error accusantium minima et, nulla cum deserunt
                accusamus quia voluptatibus modi velit a neque. Excepturi beatae
                nesciunt quam perspiciatis fugit earum corrupti cumque nisi eaque
                modi, aut blanditiis fugiat? Dolores voluptas ipsa totam dolore quas
                corrupti vel exercitationem, delectus voluptatem nesciunt et iusto
                ducimus eos aut eligendi quos earum itaque doloribus? Nemo,
                perspiciatis sapiente cupiditate amet dolorum ipsam quam? Quam
                provident perspiciatis praesentium inventore culpa dicta facilis quod
                eaque nihil consequatur tempore, possimus, reprehenderit, voluptatem
                suscipit quae ullam mollitia libero? Obcaecati quisquam vitae
                doloremque reiciendis consequatur error magni aperiam! Ratione quia
                sunt officiis eum dolorum impedit officia, itaque suscipit, et eaque
                non nulla vitae iste porro excepturi temporibus voluptatibus explicabo
                at ut qui consequatur reiciendis. Doloribus deleniti expedita velit.
                Omnis iure quia dolores vitae quaerat reprehenderit. Ducimus
                dignissimos necessitatibus, aperiam excepturi earum fugiat aut
                explicabo quibusdam repudiandae? Natus necessitatibus facere quasi
                quia adipisci nihil cupiditate ullam officia deleniti amet! Nesciunt
                facilis placeat molestiae quisquam! Sed accusantium numquam facere!
                Ratione, quibusdam? Laudantium in, nisi corrupti delectus esse veniam
                est neque obcaecati. Quasi beatae natus debitis itaque asperiores quam
                obcaecati eaque? Nam ab nemo maiores inventore blanditiis voluptas
                ipsum, a nobis praesentium eum, consectetur hic quos nostrum dolorum
                illum tempore. Ipsa similique nulla quas saepe amet debitis quasi
                ratione iste suscipit? Modi quam molestiae aut in! Debitis eveniet
                labore qui eligendi explicabo vel provident recusandae laborum quasi
                cum, quia quisquam, beatae iusto laudantium aliquid maiores, molestiae
                minus dolore voluptatum dolorum? Quo. Nisi nulla debitis modi sequi!
                Facilis soluta excepturi ullam porro ea fuga laborum recusandae totam
                reprehenderit sunt, natus laudantium aut incidunt illum nam quis iusto
                enim dicta! Odio, architecto culpa. Quisquam perferendis dolores eos
                voluptate laborum quia eligendi incidunt autem quae doloremque id
                reiciendis blanditiis error hic nostrum ipsam distinctio
                exercitationem iusto, culpa sit! Inventore esse sunt blanditiis odit
                adipisci. Enim, tempora fugiat dolores ratione iusto non. Aut odit
                praesentium commodi, aliquid aspernatur adipisci quo fugit ipsam nemo
                earum tempora vero laborum at provident in quisquam nisi molestiae
                tenetur perferendis? Voluptates libero illo, fugit quis quaerat ullam
                facilis odit! Corrupti delectus rerum id, maxime velit dolores rem
                reprehenderit molestias ad provident nesciunt dolore, consectetur
                repellat itaque, assumenda qui suscipit quibusdam! Debitis officiis
                dolores inventore labore. Eveniet provident suscipit ratione, minus
                eligendi dolores a veritatis eos, quae laudantium voluptatem,
                doloremque obcaecati recusandae? Mollitia quam earum consequatur hic
                autem fuga inventore cumque! Vel, tempore! Atque perspiciatis ea sunt
                facere voluptate officia magni nobis sapiente suscipit aliquid natus,
                delectus, molestias tenetur nam sit veniam in dolorem nihil iste vel
                dolorum tempora. Veritatis, sed. Doloremque eius nesciunt illum id
                quidem cupiditate labore placeat accusantium minima nemo eveniet,
                consectetur voluptatem facilis fugiat sed harum veniam eaque dolor
                voluptates ex dolores laudantium. Officiis provident vel dignissimos.
                Odio repellendus sapiente tempore porro beatae quidem aut consectetur
                sequi aspernatur! Pariatur dolorum id ipsam quibusdam, quasi
                necessitatibus cupiditate totam natus deleniti maxime, optio tenetur
                debitis quis ut. Voluptate, deleniti? Quia dolorem deleniti vitae
                distinctio nesciunt odio repellat itaque magni accusantium doloribus.
                Iusto consectetur, ullam eaque quod nobis ipsam, dolorum suscipit
                sapiente quo nulla omnis recusandae natus quas voluptatum obcaecati?
                Dignissimos eos nulla repudiandae inventore doloremque culpa ut, illum
                assumenda expedita tenetur. Distinctio, cumque consequuntur.
                Perferendis nobis, ipsum dignissimos velit exercitationem, dolor animi
                magni dicta excepturi libero cumque maxime quisquam. At iure optio
                labore unde, aut quos incidunt eum? Veritatis in sit, excepturi
                aperiam at voluptatibus et nesciunt quam omnis nemo ad reprehenderit
                fugit earum culpa illo aut sed amet. Aliquam minus nemo excepturi ut
                sunt debitis. Voluptate earum voluptatum dolorum recusandae libero?
                Rerum expedita perferendis praesentium, commodi incidunt repellendus
                amet, qui explicabo tempora ipsa, maiores pariatur. Dolore, dolorem
                molestiae. Perspiciatis dolorum tenetur sequi perferendis incidunt
                expedita cumque atque quae? Quisquam quod nulla at ab. Labore ab,
                illum possimus dolores animi esse, cupiditate cumque tenetur commodi
                quia odit explicabo reprehenderit? Possimus repellendus dolore
                necessitatibus ipsam harum magni incidunt nam qui libero voluptatum
                repudiandae consectetur quo consequatur rerum, voluptate voluptatem
                vero nemo molestias temporibus deleniti dolor natus facere quae sequi.
                Obcaecati. Consectetur, nobis tenetur perspiciatis vero illo tempore
                doloremque incidunt dignissimos dolorem laudantium modi quas adipisci
                repellat porro saepe eius exercitationem eos nemo autem magnam quam
                enim voluptas omnis quia. Cupiditate? Vero nisi neque quasi? Porro
                molestiae ipsam eaque autem ratione ex natus eum voluptates, vitae
                similique vero reiciendis dignissimos in blanditiis quod mollitia eius
                perspiciatis. Voluptas officia et itaque deserunt. Officia ut magnam
                cumque labore ipsa cupiditate nihil sequi deleniti, sed similique, eos
                commodi suscipit, fuga veritatis dignissimos nulla et iure dolores
                ipsum eum iusto quod nemo aperiam! Odio, voluptate. Id, quod dolorum.
                Repellat nihil incidunt dolorum commodi ad ratione consequatur quaerat
                quae repudiandae et, id maiores corporis eius suscipit fuga quam sit
                alias provident atque odit voluptas rerum quisquam. Soluta vitae
                tenetur minima, commodi rerum laborum, rem, nobis voluptas assumenda
                fugit est molestias dicta sed officiis tempore ratione modi esse aut
                iusto doloribus? Fugit dolorum eaque delectus aperiam unde. Impedit
                numquam illo, aut, dignissimos nam excepturi necessitatibus aperiam
                delectus inventore dolores distinctio ex molestias architecto?
                Adipisci inventore laudantium quisquam vitae, nulla voluptates!
                Consectetur veniam quam molestias nobis? Officiis, possimus. Ut,
                dolore. Nesciunt sunt impedit possimus fugit quos et illo nulla
                temporibus veniam rerum beatae praesentium perferendis at adipisci
                labore quia libero animi quam dolor delectus, sapiente laboriosam
                perspiciatis fugiat? Vel rem quisquam enim accusantium natus
                laudantium porro esse similique. Facilis tempore sed veniam adipisci
                ullam dolorum? Consequuntur adipisci, optio maiores error ipsa
                perspiciatis quasi dicta ducimus fuga obcaecati iste! Quam,
                consectetur dolorem officia placeat ipsa quibusdam enim dicta ex odit
                reprehenderit eius blanditiis minus sit beatae eaque accusamus
                laboriosam molestias harum laudantium animi suscipit veritatis. Quam
                aliquam quibusdam expedita? Labore nam facere, molestias magnam, neque
                doloremque veniam vero et accusamus cupiditate at pariatur corporis
                ut. Atque error cupiditate architecto, optio distinctio alias
                pariatur, minima dolorum itaque omnis vero deleniti. Cupiditate ullam
                rerum recusandae dolorem, nobis delectus nam vel corrupti sapiente
                amet repellat enim incidunt nihil magnam at. Sequi, vitae id labore
                assumenda nobis ab optio sunt. Hic, alias sapiente. Neque, repellat
                sit? Debitis magni ullam, eos placeat incidunt repellat vero qui
                necessitatibus? Voluptate fugit qui expedita? Laboriosam cum nam non
                voluptates culpa, repudiandae quisquam incidunt, perspiciatis
                laudantium laborum quod! Sunt consequatur laborum dolores perferendis!
                Vitae quidem itaque id autem sint repudiandae ullam consequuntur nam
                corporis. Culpa totam ex quia perferendis aspernatur, at unde tenetur
                quis, blanditiis, veritatis velit sint? Quo impedit, culpa distinctio
                earum dolorum pariatur. Nulla accusantium deserunt eligendi cumque
                veritatis accusamus, eos tempora harum ipsum possimus iusto quis
                voluptatum ab numquam neque tempore, facere a architecto aliquam?
                Assumenda ea nesciunt iure similique saepe consequuntur. In vel
                suscipit dolores iusto ipsam amet eum quasi, quas numquam ducimus
                molestiae explicabo possimus placeat dolor, cupiditate quos deserunt
                quaerat ipsa quisquam. Eligendi quo doloremque saepe, voluptatibus
                iste eaque? Temporibus sunt fuga id vitae sequi inventore quidem
                expedita beatae, odit autem itaque aperiam nostrum deserunt maiores ea
                eaque voluptates officiis repellendus magnam? Eaque fuga provident
                placeat at hic dolorem, voluptas dolorum voluptatibus temporibus optio
                iusto ipsum reprehenderit nihil, minus soluta neque earum. Nobis, sint
                laboriosam? Omnis debitis sunt dolorem fugiat cum vero. Praesentium
                velit iste, perspiciatis nobis accusantium temporibus iusto quaerat
                totam nam ad assumenda necessitatibus, porro qui error quidem eaque
                corrupti unde, deserunt impedit architecto eum sequi veniam? Neque,
                fugiat illo. At eveniet ullam cumque assumenda repudiandae minus
                soluta nihil repellat suscipit voluptas, optio voluptate nemo
                inventore praesentium modi voluptatum quia blanditiis eum obcaecati
                rerum quisquam excepturi aperiam tempora. Ducimus, excepturi. Unde
                amet libero explicabo, ullam quam optio harum eaque esse repudiandae
                illum tempora tenetur, facere rerum! Voluptate quis doloribus
                quibusdam velit ullam, sunt similique eos laborum reprehenderit
                officia tenetur necessitatibus. Quisquam ea beatae commodi libero
                assumenda deserunt alias nisi aliquid aliquam eligendi est quas cum
                ratione iusto tenetur sunt, quia praesentium tempora voluptatibus
                possimus quidem distinctio necessitatibus rem! Officia, facilis. Natus
                delectus recusandae quaerat placeat provident, laudantium atque quas
                laborum? Saepe earum eos impedit harum nostrum assumenda, reiciendis
                tempora facilis eveniet nihil modi incidunt nobis quo, et cupiditate
                magni temporibus. Unde doloremque fugit natus officia consequuntur
                reprehenderit quas qui, at accusantium in quo cum quisquam assumenda
                distinctio laborum nisi nostrum, exercitationem quis sequi, itaque
                temporibus. Iusto exercitationem hic provident cum? Iure tempore dolor
                ut numquam. Saepe, at. Consequatur quibusdam deleniti natus magnam
                quaerat. Sed, deserunt impedit asperiores blanditiis deleniti
                laudantium quisquam! Repellendus provident beatae excepturi nulla
                veritatis ab quidem vitae? Possimus, praesentium modi officiis, labore
                porro mollitia magnam cupiditate aliquam, quia ad fugiat natus
                doloribus fuga. Commodi praesentium alias, doloremque amet eligendi
                placeat eum error incidunt quae doloribus hic cumque. Vero, facilis
                culpa nisi magnam consequuntur fugit, dolorum obcaecati sequi
                assumenda quibusdam maiores ipsa quisquam voluptatibus laboriosam
                itaque cum. Culpa suscipit doloremque perspiciatis, itaque ex in error
                et eaque modi. Tenetur saepe, dignissimos ullam nostrum asperiores,
                animi nulla amet aut, unde omnis architecto exercitationem? Atque,
                vitae libero! Placeat qui cupiditate beatae voluptatum, cum cumque
                iste. Consequuntur facilis aspernatur veniam necessitatibus.
            </p>
        </section>
    </main>

    <div class="divider container" style="max-width: 1100px"></div>

    <!-- FOOTER -->
    <footer>
        <div class="container" style="max-width: 1100px">
            <div class="footer-grid">
                <div>
                    <h4>StockPhone</h4>
                    <p class="small">
                        Hệ thống quản lý kho chuyên cho cửa hàng điện thoại. Quản lý tồn
                        kho, đơn nhập/xuất, báo cáo và người dùng.
                    </p>
                </div>

                <div>
                    <h4>Quick links</h4>
                    <a href="home.html">Home</a>
                    <a href="/products">Products</a>
                    <a href="/reports">Reports</a>
                    <a href="/login">Đăng nhập</a>
                </div>

                <div>
                    <h4>Hỗ trợ & Policy</h4>
                    <a href="/policy">Privacy & Policy</a>
                    <a href="/terms">Terms of Service</a>
                    <a href="/help">Help Center</a>
                </div>

                <div>
                    <h4>Contact</h4>
                    <div class="small">Email: support@stockphone.example</div>
                    <div class="small" style="margin-top: 6px">
                        SĐT: +84 912 345 678
                    </div>
                    <div style="margin-top: 10px">
                        <a
                            href="#"
                            style="
                            margin-right: 8px;
                            text-decoration: none;
                            color: var(--muted);
                            "
                            >Twitter</a
                        >
                        <a
                            href="#"
                            style="
                            margin-right: 8px;
                            text-decoration: none;
                            color: var(--muted);
                            "
                            >Facebook</a
                        >
                        <a href="#" style="text-decoration: none; color: var(--muted)"
                           >LinkedIn</a
                        >
                    </div>
                </div>
            </div>

            <div
                style="
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-top: 18px;
                flex-wrap: wrap;
                "
                >
                <div class="small">
                    © " + new Date().getFullYear() + " StockPhone. All rights reserved.
                </div>
                <div class="small">Designed for warehouse management</div>
            </div>
        </div>
    </footer>

    <script>
        // Mobile menu toggle
        const ham = document.getElementById("hamburger");
        const mobile = document.getElementById("mobileMenu");
        if (ham) {
            ham.addEventListener("click", () => {
                const open = ham.getAttribute("aria-expanded") === "true";
                ham.setAttribute("aria-expanded", String(!open));
                if (mobile.hasAttribute("hidden"))
                    mobile.removeAttribute("hidden");
                else
                    mobile.setAttribute("hidden", "");
            });
        }
    </script>
</body>
</html>

