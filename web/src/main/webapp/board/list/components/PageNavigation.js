function createPageNavigation(maxPage, curPage, naviPerPage, filter, searchQuery) {
    if (maxPage > 1) {
        let nav = $("<nav>");
        let ul = $("<ul>").addClass("pagination");

        let prevArrow = $("<li>").addClass("page-item");
        let prevArrowLink = $("<a>").addClass("page-link arrow");

        let nextArrow = $("<li>").addClass("page-item");
        let nextArrowLink = $("<a>").addClass("page-link arrow");

        if (curPage <= naviPerPage) {
            prevArrow.addClass("disabled");
        }

        if (curPage > Math.floor(maxPage / naviPerPage) * naviPerPage) {
            nextArrow.addClass("disabled");
        }

        let prevPageLast = Math.floor((curPage - 1) / naviPerPage) * naviPerPage;
        let nextPageFirst = prevPageLast + naviPerPage + 1;

        if (filter !== -1) {
            filterOpt = "&filter=" + filter;
            prevPageLast += filterOpt;
            nextPageFirst += filterOpt;
        }

        if (searchQuery) {
            searchQueryOpt = "&searchQuery=" + searchQuery;
            prevPageLast += searchQueryOpt;
            nextPageFirst += searchQueryOpt;
        }

        prevArrowLink.html("<i class='bi bi-arrow-left'></i>");
        nextArrowLink.html("<i class='bi bi-arrow-right'></i>");

        prevArrowLink.on("click", () => {
            setBoardListAndNav(filter, prevPageLast, searchQuery);
        })
        nextArrowLink.on("click", () => {
            setBoardListAndNav(filter, nextPageFirst, searchQuery);
        })

        prevArrow.append(prevArrowLink);
        nextArrow.append(nextArrowLink);

        ul.append(prevArrow);

        let navFirstPage = Math.floor((curPage - 1) / naviPerPage) * naviPerPage + 1;
        for (let i = navFirstPage; i < navFirstPage + naviPerPage; i++) {
            if (i <= maxPage) {
                let navItem = $("<li>").addClass("page-item");
                let navLink = $("<a>").addClass("page-link");

                navLink.on("click", () => {
                    setBoardListAndNav(filter, i, searchQuery);
                })
                navLink.html(i);
                if (i === curPage) {
                    navLink.addClass("active");
                }
                navItem.append(navLink);

                ul.append(navItem);
            }
        }

        ul.append(nextArrow);

        nav.append(ul);
        $("#navPos").html("");
        $("#navPos").append(nav);
    }
}