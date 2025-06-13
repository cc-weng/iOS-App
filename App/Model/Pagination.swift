//
//  Pagination.swift
//  focus
//
//  Created by ccweng on 2025/6/13.
//

import Foundation

struct PaginationReq {
    let page: Int
    let pageSize: Int
    let offset: Int
    
    init(
        page: Int = 1,
        pageSize: Int = 20
    ) {
        self.page = max(1, page)
        self.pageSize = max(1, min(pageSize, 100))
        self.offset = (self.page - 1) * self.pageSize
    }
}

struct PaginationRsp<T> {
    let page: Int
    let pageSize: Int
    let total: Int
    let list: [T]
    
    init(page: Int, pageSize: Int, total: Int, list: [T]) {
        self.page = page
        self.pageSize = pageSize
        self.total = total
        self.list = list
    }
}
