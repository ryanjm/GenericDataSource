//
//  DidUpdateFocusTester.swift
//  GenericDataSource
//
//  Created by Mohamed Ebrahim Mohamed Afifi on 3/15/17.
//  Copyright © 2017 mohamede1945. All rights reserved.
//

import Foundation
import GenericDataSource
import XCTest

private class _ReportBasicDataSource<CellType>: ReportBasicDataSource<CellType> where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {

    var called = false

    @available(iOS 9.0, *)
    override func ds_collectionView(_ collectionView: GeneralCollectionView, didUpdateFocusIn context: GeneralCollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        called = true
    }
}

class DidUpdateFocusTester<CellType>: DataSourceTester where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {
    let dataSource: ReportBasicDataSource<CellType> = _ReportBasicDataSource<CellType>()

    required init(id: Int, numberOfReports: Int, collectionView: GeneralCollectionView) {
        dataSource.items = Report.generate(numberOfReports: numberOfReports)
        dataSource.registerReusableViewsInCollectionView(collectionView)
    }

    func test(indexPath: IndexPath, dataSource: AbstractDataSource, tableView: UITableView) -> Void {
        return dataSource.tableView(tableView, didUpdateFocusIn: UITableViewFocusUpdateContext(), with: UIFocusAnimationCoordinator())
    }

    func test(indexPath: IndexPath, dataSource: AbstractDataSource, collectionView: UICollectionView) -> Void {
        return dataSource.collectionView(collectionView, didUpdateFocusIn: UICollectionViewFocusUpdateContext(), with: UIFocusAnimationCoordinator())
    }

    func assert(result: Void, indexPath: IndexPath, collectionView: GeneralCollectionView) {
    }

    func assertNotCalled(collectionView: GeneralCollectionView) {
        XCTFail()
    }
}

class DidUpdateFocusTester2<CellType>: DidUpdateFocusTester<CellType> where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {

    override func assert(result: Void, indexPath: IndexPath, collectionView: GeneralCollectionView) {
        XCTFail()
    }

    override func assertNotCalled(collectionView: GeneralCollectionView) {
        // should be called
    }
}