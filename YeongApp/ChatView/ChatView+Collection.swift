//
//	ChatView+Collection.swift
//	YeongApp
//

import UIKit

extension ChatView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    func setChatCollectionView() {
        chatCollectionView.delegate = self
        chatCollectionView.dataSource = self
        
        chatCollectionView.register(UINib(nibName: TextCell.identifier, bundle: nil), forCellWithReuseIdentifier: TextCell.identifier)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 8
        flowLayout.estimatedItemSize = CGSize(width: chatCollectionView.frame.width, height: 35)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chatDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = chatCollectionView.dequeueReusableCell(withReuseIdentifier: TextCell.identifier, for: indexPath) as? TextCell {
            cell.bind(with: chatDatas[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = chatCollectionView.bounds.width
        let estimatedHeight: CGFloat = 28
        let dummyFrame = CGRect(x: 0, y: 0, width: cellWidth, height: estimatedHeight)
        
        let dummyTextCell = TextCell(frame: dummyFrame)
        let estimatedSize = dummyTextCell.systemLayoutSizeFitting(CGSize(width: cellWidth, height: estimatedHeight))
        return CGSize(width: cellWidth, height: estimatedSize.height)
    }
    
}
