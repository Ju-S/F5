function createPageNavigation(maxPage, curPage, naviPerPage) {
    let params = new URLSearchParams(window.location.search);

    let searchOpt = params.get("searchOpt");
    let search = params.get("search");

    if (maxPage > 1) {
        let nav = $("<nav>");
        let ul = $("<ul>").addClass("pagination");

        let prevArrow = $("<li>").addClass("page-item");
        let prevArrowLink = $("<a>").addClass("page-link");

        let nextArrow = $("<li>").addClass("page-item");
        let nextArrowLink = $("<a>").addClass("page-link");

        if (curPage <= naviPerPage) {
            prevArrow.addClass("disabled");
        }

        if (curPage > maxPage - naviPerPage) {
            nextArrow.addClass("disabled");
        }

        let searchParams = "";
        if (search != null) {
            params += "&searchOpt=" + searchOpt;
            params += "&search=" + search;
        }

        let prevPageLast = Math.floor((curPage - 1) / naviPerPage) * naviPerPage;
        let nextPageFirst = prevPageLast + naviPerPage + 1;

        prevArrowLink.attr("href", "?page=" + prevPageLast + searchParams).html("&laquo;");
        nextArrowLink.attr("href", "?page=" + nextPageFirst + searchParams).html("&raquo;");

        prevArrow.append(prevArrowLink);
        nextArrow.append(nextArrowLink);

        ul.append(prevArrow);

        let navFirstPage = Math.floor((curPage - 1) / naviPerPage) * naviPerPage + 1;
        for (let i = navFirstPage; i < navFirstPage + naviPerPage; i++) {
            if (i <= maxPage) {
                let navItem = $("<li>").addClass("page-item");
                let navLink = $("<a>").addClass("page-link");

                navLink.attr("href", "?page=" + i + searchParams).html(i);
                if (i === curPage) {
                    navLink.addClass("active");
                }
                navItem.append(navLink);

                ul.append(navItem);
            }
        }

        ul.append(nextArrow);

        nav.append(ul);

        $("#navPos").append(nav);
    }
}