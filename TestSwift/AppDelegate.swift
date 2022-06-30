//
//  AppDelegate.swift
//  TestSwift
//
//  Created by  joy on 2022/5/31.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

//        let ccc = "{}[]"
//        let arr : Array<Character> = Array(ccc)
//        print(arr)
        
//        var ttt = [3,2,1]
//        var result = [[1,2,3],[4,5,6],[7,8,9]]
//        self.rotate(&result)
//        var result = [[1,0,1],[1,1,1],[1,1,1]]
//        let result =  self.exist([["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]],
//                   "SEE")
//
//        print(result)
        let head = ListNode(1)
        var node: ListNode? = head
        node?.next = ListNode(2)
        node = node?.next
        node?.next = ListNode(3)
        node = node?.next
        node?.next = ListNode(4)
        node = node?.next
        node?.next = ListNode(5)
////        node = node?.next
////        node?.next = ListNode(2)
//        reverseBetween(head, 2,4)
        let tree = TreeNode(1)
        tree.left = TreeNode(2)
        tree.right = TreeNode(3)
        
        hasPathSum(tree,5)
        print(restoreIpAddresses("25525511135"))

        
        return true
    }
    
    func hasPathSum(_ root: TreeNode?, _ targetSum: Int) -> Bool {
        if root == nil {
            return false
        }
        if root?.left == nil && root?.right == nil {
            if targetSum == root!.val {
                return true
            }
            return false
        }
        
        let leftCheck = hasPathSum(root?.left, targetSum - root!.val)
        let rightCheck = hasPathSum(root?.right, targetSum - root!.val)
        return leftCheck || rightCheck
    }
    
    func minDepth(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        if root?.left == nil && root?.right == nil {
            return 1
        }
        return min(root?.left != nil ? minDepth(root?.left) : Int.max,root?.right != nil ? minDepth(root?.right) : Int.max) + 1
    }
    
    func isBalanced(_ root: TreeNode?) -> Bool {
        if root == nil {
            return true
        }
        func treeDeep(_ head: TreeNode?) -> Int {
            if head == nil {
                return 0
            }
            return max(treeDeep(head?.left), treeDeep(head?.right)) + 1
        }
        let leftDeep = treeDeep(root?.left)
        let rightDeep = treeDeep(root?.right)
        return (abs(leftDeep-rightDeep) <= 1) && isBalanced(root?.left) && isBalanced(root?.right)
    }
    
    func sortedListToBST(_ head: ListNode?) -> TreeNode? {
        if head == nil {
            return nil
        }
        let preNode = ListNode()
        preNode.next = head
        var fastNode = head?.next
        var slowNode: ListNode? = preNode
        while fastNode != nil {
            fastNode = fastNode?.next?.next
            slowNode = slowNode?.next
        }
        let root = TreeNode(slowNode!.next!.val)
        let rightNode = slowNode?.next?.next
        slowNode?.next = nil
        root.left = sortedListToBST(preNode.next)
        root.right = sortedListToBST(rightNode)
        return root
    }
    
    func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
        guard nums.count > 0 else {return nil}
        let midIndex = nums.count / 2
        let root = TreeNode(nums[midIndex])
        if midIndex > 0 {
            root.left = sortedArrayToBST(Array(nums[0..<midIndex]))
        }
        if midIndex < nums.count {
            root.right = sortedArrayToBST(Array(nums[midIndex+1..<nums.count]))
        }
        return root
    }
    
    func levelOrderBottom(_ root: TreeNode?) -> [[Int]] {
        guard root != nil else {return [[]]}
        var arr = [TreeNode]()
        arr.append(root!)
        var result = [[Int]]()
        while arr.count > 0 {
            var nextArr = [TreeNode]()
            var cResult = [Int]()
            for node in arr {
                cResult.append(node.val)
                if let lNode = node.left {
                    nextArr.append(lNode)
                }
                if let rNode = node.right {
                    nextArr.append(rNode)
                }
            }
            arr = nextArr
            if cResult.count > 0 {
                result.insert(cResult, at: 0)
            }
        }
        return result
    }
    
    func buildTree(_ inorder: [Int], _ postorder: [Int]) -> TreeNode? {
        guard inorder.count > 0 && inorder.count == postorder.count else {return nil}
        func subBuildTree(_ leftI: Int, _ rightI: Int, _ leftP: Int, _ rightP : Int) -> TreeNode? {
            if leftI > rightI || leftP > rightP {
                return nil
            }
            let val = postorder[rightP]
            var offSet = -1
            for i in 0...(rightI-leftI) {
                if inorder[i+leftI] == val {
                    offSet = i
                    break
                }
            }
            guard offSet >= 0 else {return nil}
            let root = TreeNode(val)
            root.left = subBuildTree(leftI, leftI+offSet-1, leftP, leftP+offSet-1)
            root.right = subBuildTree(leftI+offSet+1, rightI, leftP+offSet, rightP-1)
            return root
        }
        return subBuildTree(0, inorder.count-1, 0, postorder.count-1)
    }
    
    
//    func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
//        if preorder.count != inorder.count || inorder.count == 0 {
//            return nil
//        }
//        func subBuildTree(_ preorderLeft:Int, _ preorderRight:Int, _ inorderLeft: Int,_ inorderRight: Int)  -> TreeNode? {
//            if preorderLeft > preorderRight || inorderLeft > inorderRight {
//                return nil
//            }
//            let root = TreeNode(preorder[preorderLeft])
//            if preorderLeft == preorderRight {
//                return root
//            }
//            var leftCount = 0
//            for i in 0...(inorderRight-inorderLeft) {
//                if inorder[i+inorderLeft] == root.val {
//                    leftCount = i
//                    break
//                }
//            }
//            root.left = subBuildTree(preorderLeft+1, preorderLeft+leftCount, inorderLeft, inorderLeft+leftCount-1)
//            root.right = subBuildTree(preorderLeft+leftCount+1, preorderRight, inorderLeft+leftCount+1, inorderRight)
//            return root
//        }
//        return subBuildTree(0,preorder.count-1,0,inorder.count-1)
//    }
    
    func maxDepth(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        let leftDeep = maxDepth(root?.left)
        let rightDeep = maxDepth(root?.right)
        return max(leftDeep, rightDeep) + 1
    }
    
    func zigzagLevelOrder(_ root: TreeNode?) -> [[Int]] {
        if root == nil {
            return []
        }
        var result = [[Int]]()
        var leftDirection = true
        func subLevelOrder(_ nodeArr: Array<TreeNode>) {
            if nodeArr.isEmpty {
                return
            }
            var valArr = [Int]()
            var nextNodeArr = [TreeNode]()
            for node in nodeArr {
                valArr.append(node.val)
                if let leftNode = node.left {
                    nextNodeArr.append(leftNode)
                }
                if let rightNode = node.right {
                    nextNodeArr.append(rightNode)
                }
            }
            result.append(leftDirection ? valArr : valArr.reversed())
            leftDirection = !leftDirection
            subLevelOrder(nextNodeArr)
        }
        subLevelOrder([root!])
        return result
    }
    
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        if root == nil {
            return []
        }
        var result = [[Int]]()
        func subLevelOrder(_ nodeArr: Array<TreeNode>) {
            if nodeArr.isEmpty {
                return
            }
            var valArr = [Int]()
            var nextNodeArr = [TreeNode]()
            for node in nodeArr {
                valArr.append(node.val)
                if let leftNode = node.left {
                    nextNodeArr.append(leftNode)
                }
                if let rightNode = node.right {
                    nextNodeArr.append(rightNode)
                }
            }
            result.append(valArr)
            subLevelOrder(nextNodeArr)
        }
        subLevelOrder([root!])
        return result
    }
    
    func isSymmetric(_ root: TreeNode?) -> Bool {
        if root == nil {
            return true
        }
        func readNext(_ lNode: TreeNode?, _ rNode: TreeNode?) -> Bool {
            if lNode == nil && rNode == nil {
                return true
            }
            if lNode == nil || rNode == nil {
                return false
            }
            let midEqual = lNode!.val == rNode!.val
            let leftEqual = readNext(lNode?.left, rNode?.right)
            let rightEqual = readNext(lNode?.right, rNode?.left)
            return midEqual && leftEqual && rightEqual
        }
        return readNext(root?.left, root?.right)
    }
    
    func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
        if p == nil && q == nil {
            return true
        }
        if p == nil || q == nil {
            return false
        }
        
        let valueSame = p!.val == q!.val
        let leftSame = isSameTree(p?.left, q?.left)
        let rightSame = isSameTree(p?.right, q?.right)
        return valueSame && leftSame && rightSame
    }
    
    
    func recoverTree(_ root: TreeNode?) {
        //进行中序遍历 找出错误节点
        var nodeStack = [TreeNode]()
        var cNode = root
        var node1: TreeNode?, node2: TreeNode?, lNode: TreeNode?

        while cNode != nil || nodeStack.count > 0 {
            while cNode != nil {
                nodeStack.append(cNode!)
                cNode = cNode?.left
            }
            cNode = nodeStack.last
            nodeStack.removeLast()
            if cNode!.val <= lNode?.val ?? Int.min {
                node2 = cNode
                if node1 == nil {
                    node1 = lNode
                }else {
                    break
                }
            }
            lNode = cNode
            cNode = cNode?.right
        }
        if node1 != nil && node2 != nil {
            (node1!.val, node2!.val) = (node2!.val, node1!.val)
        }
    }
    
    func isValidBST(_ root: TreeNode?) -> Bool {
        func subIsValidBSR(_ subRoot: TreeNode?, _ minVal: Int, _ maxVal: Int) -> Bool {
            if subRoot == nil {
                return true
            }
            let leftValid = subIsValidBSR(subRoot?.left, minVal, subRoot!.val)
            let rightValid = subIsValidBSR(subRoot?.right, subRoot!.val, maxVal)
            let rootLeftValid = subRoot!.val > max(subRoot?.left?.val ?? Int.min, minVal)
            let rootRightValid = subRoot!.val < min(subRoot?.right?.val ?? Int.max, maxVal)
            if leftValid && rightValid && rootLeftValid && rootRightValid {
                return true
            }
            return false
        }
        return subIsValidBSR(root, Int.min, Int.max)
        
        
//        if root == nil {
//            return true
//        }
//        if isValidBST(root?.left) && isValidBST(root?.right) && (root?.left == nil || root!.val > root!.left!.val) && (root?.right == nil || root!.val < root!.right!.val) {
//            return true
//        }else {
//            return false
//        }
    }
    
    func isInterleave(_ s1: String, _ s2: String, _ s3: String) -> Bool {
        guard s3.count == s1.count + s2.count else {return false}
        let s1Arr = Array(s1)
        let s2Arr = Array(s2)
        let s3Arr = Array(s3)
        var dp = Array(repeating: Array(repeating: false, count: s2Arr.count+1), count: s1Arr.count+1)
        dp[0][0] = true
        
        for s1Count in 0...s1Arr.count {
            for s2Count in 0...s2Arr.count {
                guard s1Count > 0 || s2Count > 0 else {continue}
                let s3Char = s3Arr[s1Count + s2Count - 1]
                if (s1Count > 0 && dp[s1Count-1][s2Count] && s1Arr[s1Count-1] == s3Char) || (s2Count > 0 && dp[s1Count][s2Count-1] && s2Arr[s2Count-1] == s3Char) {
                    dp[s1Count][s2Count] = true
                }
             }
        }
        return dp.last!.last!
    }
    
    func numTrees(_ n: Int) -> Int {
        guard n > 0 else {return 0}
        guard n > 1 else {return 1}
        var dp = Array(repeating: 0, count: n+1)
        dp[0] = 1
        dp[1] = 1
        for i in 2...n {
            for j in 0...i-1 {
                let leftCount = dp[j]
                let rightCount = dp[i-j-1]
                dp[i] += leftCount * rightCount
            }
        }
        return dp.last!
        
//        func subSumTree(_ start: Int, _ end: Int) -> Int {
//            guard start <= end else {return 1}
//            var count = 0
//            for i in start...end {
//                let leftCount = subSumTree(start, i-1)
//                let rightCount = subSumTree(i+1, end)
//                count += leftCount * rightCount
//            }
//            return count
//        }
//        return subSumTree(1, n)
    }
    
    func generateTrees(_ n: Int) -> [TreeNode?] {
        func subGenerateTrees(_ start: Int, _ end: Int) -> [TreeNode?] {
            guard start <= end else {return [nil]}
            var trees = [TreeNode?]()
            for i in start...end {
                let leftTrees = subGenerateTrees(start, i-1)
                let rightTrees = subGenerateTrees(i+1, end)
                for leftItem in leftTrees {
                    for rightItem in rightTrees {
                        let rootNode = TreeNode(i)
                        rootNode.left = leftItem
                        rootNode.right = rightItem
                        trees.append(rootNode)
                    }
                }
            }
            return trees
        }
        return subGenerateTrees(1, n)
    }
    
    func inorderTraversal(_ root: TreeNode?) -> [Int] {
        if root == nil {
            return []
        }
        var list = [TreeNode]()
        
        var cNode = root
        
        var result = [Int]()
        
        while cNode != nil || list.count > 0 {
            while cNode != nil {
                list.append(cNode!)
                cNode = cNode?.left
            }
            cNode = list.last!
            list.removeLast()
            result.append(cNode!.val)
            cNode = cNode?.right
        }
        return result
    }
    
    func restoreIpAddresses(_ s: String) -> [String] {
        var result = [String]()
        let sArr = Array(s)
        var path = [String]()
        func dfs(_ index:Int) {
            if index == sArr.count && path.count == 4 {
                let str = path.joined(separator: ".")
                result.append(str)
                return
            }
            if path.count >= 4 || index >= sArr.count {
                return
            }
            func pushPath(_ count:Int) {
                path.append(String(sArr[index..<index+count]))
                dfs(index+count)
                path.removeLast()
            }

            let firstChar = sArr[index].wholeNumberValue!
            pushPath(1)

            if index + 1 < sArr.count && firstChar > 0 {
                let secondChar = sArr[index+1].wholeNumberValue!
                pushPath(2)
                if index + 2 < sArr.count {
                    let thirdChar = sArr[index+2].wholeNumberValue!
                    if firstChar == 1 || (firstChar == 2 && (secondChar < 5 || (secondChar == 5 && thirdChar < 6))) {
                        pushPath(3)
                    }
                }
            }
        }
        dfs(0)
        return result
    }
    
    
    
//    func restoreIpAddresses(_ s: String) -> [String] {
//        let sArr = Array(s)
//        var result = [String]()
//        func subRestoreIpAddresses(_ leaveSArr:Array<Character>, _ preArr:[[Character]]) {
//            if leaveSArr.isEmpty {
//                if preArr.count == 4 {
//                    var str = ""
//                    str += String(preArr.first!)
//                    for i in 1..<preArr.count {
//                        str += "."
//                        str += String(preArr[i])
//                    }
//                    result.append(str)
//                }
//                return
//            }
//            if preArr.count > 4 {
//                return
//            }
//
//            let firstChar = leaveSArr.first!.wholeNumberValue!
//            subRestoreIpAddresses(Array(leaveSArr[1..<leaveSArr.count]), preArr+[[leaveSArr.first!]])
//            if firstChar != 0 {
//                if leaveSArr.count >= 2 {
//                    subRestoreIpAddresses(Array(leaveSArr[2..<leaveSArr.count]), preArr+[Array(leaveSArr[0..<2])])
//                }
//                if leaveSArr.count >= 3 {
//                    let secondChar = leaveSArr[1].wholeNumberValue!
//                    let thirdChar = leaveSArr[2].wholeNumberValue!
//                    if firstChar == 1 || (firstChar == 2 && (secondChar < 5 || (secondChar == 5 && thirdChar < 6))) {
//                        subRestoreIpAddresses(Array(leaveSArr[3..<leaveSArr.count]), preArr+[Array(leaveSArr[0..<3])])
//                    }
//                }
//            }
//        }
//        subRestoreIpAddresses(sArr, [])
//        return result
//    }
    
    func reverseBetween(_ head: ListNode?, _ left: Int, _ right: Int) -> ListNode? {
        let preNode = ListNode()
        preNode.next = head
        var leftPreNode: ListNode? = preNode
        var leftNode: ListNode? = head
        for _ in 0..<left-1 {
            leftPreNode = leftPreNode?.next
            leftNode = leftNode?.next
        }
        let preOne = leftNode
        leftNode = leftNode?.next
        for _ in 0..<right-left {
            let nextNode = leftPreNode?.next
            leftPreNode?.next = leftNode
            leftNode = leftNode?.next
            leftPreNode?.next?.next = nextNode
        }
        preOne?.next = leftNode
        return preNode.next
    }
    
    
    
    func numDecodings(_ s: String) -> Int {
        let sArr = Array(s)
        if sArr.isEmpty || sArr.first! == "0" {
            return 0
        }
        var dp = Array(repeating: 0, count: sArr.count + 1)
        dp[0] = 1
        dp[1] = 1
        for i in 1..<sArr.count {
            let value = sArr[i].wholeNumberValue!
            let preValue = sArr[i-1].wholeNumberValue!
            if value > 0 {
                dp[i+1] += dp[i]
            }
            if (preValue == 1 || (preValue == 2 && value <= 6 )) {
                dp[i+1] += dp[i-1]
            }
        }
        return dp.last!
//        func subBymDecodings(_ leaveSArr:Array<Character>) {
//            if leaveSArr.isEmpty {
//                resultCount += 1
//                return
//            }
//            let firstChar = leaveSArr.first!.wholeNumberValue!
//            if firstChar != 0 {
//                var nextArr = leaveSArr
//                nextArr.removeFirst()
//                subBymDecodings(nextArr)
//                if leaveSArr.count >= 2 {
//                    let secondChar = leaveSArr[1].wholeNumberValue!
//                    if firstChar == 1 || (firstChar == 2 && secondChar <= 6) {
//                        nextArr.removeFirst()
//                        subBymDecodings(nextArr)
//                    }
//                }
//            }
//        }
//        subBymDecodings(sArr)
//        return resultCount
    }
    
    func subsetsWithDup(_ nums: [Int]) -> [[Int]] {
        var map = [Int:Int]()
        for num in nums {
            map[num, default: 0] += 1
        }
        var result = [[Int]]()
        func subSubsetsWithDup(_ usedMap:[Int:Int] , _ preResult:[Int]) {
            if usedMap.isEmpty {
                result.append(preResult)
                return
            }
            let usedNum = usedMap.keys.first!
            let count = usedMap[usedNum]!
            var nextMap = usedMap
            nextMap.removeValue(forKey: usedNum)
            var usedArr = preResult
            subSubsetsWithDup(nextMap, usedArr)
            for _ in 1...count {
                usedArr.append(usedNum)
                subSubsetsWithDup(nextMap, usedArr)
            }
        }
        subSubsetsWithDup(map,[])
        return result
    }
    
    func grayCode(_ n: Int) -> [Int] {
        var res = [Int]()
        for i in 0 ..< 1 << n {
            res.append(i ^ i >> 1)
        }
        return res
    }

    
//    func grayCode(_ n: Int) -> [Int] {
//        var result = [Int]()
//        func subGrayCode(_ leaveN: Int,_ preResult:[Int]) {
//
//
//        }
//        subGrayCode(n, [])
//        return result
//    }
    
    func partition(_ head: ListNode?, _ x: Int) -> ListNode? {

        let preNode = ListNode()
        var cNode: ListNode? = preNode
        
        let originPreNode = ListNode()
        var oNode: ListNode? = originPreNode
        
        var tmpNode: ListNode? = head
        while tmpNode != nil {
            if tmpNode!.val < x {
                cNode?.next = tmpNode
                cNode = cNode?.next
            }else {
                oNode?.next = tmpNode
                oNode = oNode?.next
            }
            let preTmp = tmpNode
            tmpNode = tmpNode?.next
            preTmp?.next = nil
        }
        cNode?.next = originPreNode.next
        return preNode.next
    }
    
    func exist(_ board: [[Character]], _ word: String) -> Bool {
        let wordArr = Array(word)
        var result = false
        func subExist(_ preX:Int, _ preY:Int, _ indexArr:[(Int,Int)]) {
            if result == true {
                return
            }
            if indexArr.count == wordArr.count  {
                result = true
                return
            }
            if preX >= board.count  || preY >= board.first!.count || preY < 0 || preX < 0 {
                return
            }
            let char = wordArr[indexArr.count]
            if board[preX][preY] != char {
                return
            }
            if indexArr.contains(where: { (x, y) in
                preX == x && preY == y
            }) {
                return
            }
            let nextArr = indexArr + [(preX,preY)]
            subExist(preX+1, preY, nextArr)
            subExist(preX, preY+1, nextArr)
            subExist(preX-1, preY, nextArr)
            subExist(preX, preY-1, nextArr)
        }
        for i in 0..<board.count {
            for j in 0..<board.first!.count {
                subExist(i, j, [])
                if result == true {
                    break
                }
            }
            if result == true {
                break
            }
        }
        return result
    }
    
    func subsets(_ nums: [Int]) -> [[Int]] {
        var result = [[Int]]()
        if nums.isEmpty {
            return result
        }
        func subSubsets(_ leaveNums: [Int], _ preResults:[Int]) {
            if leaveNums.isEmpty {
                result.append(preResults)
                return
            }
            
            let nextNums = Array(leaveNums[1..<leaveNums.count])
            let nextResult = [leaveNums[0]] + preResults
            subSubsets(nextNums, preResults)
            subSubsets(nextNums, nextResult)
        }
        subSubsets(nums, [])
        return result
    }
    
    
    func combine(_ n: Int, _ k: Int) -> [[Int]] {
        if n < k {
            return [[Int]]()
        }
        var result = [[Int]]()
        func subCombine(_ index: Int, _ leave: Int, _ preResult: [Int]) {
            if index < leave {
                return
            }
            if leave == 0 {
                result.append(preResult)
                return
            }
            subCombine(index-1, leave-1, [index] + preResult)
            subCombine(index-1, leave, preResult)
        }
        subCombine(n, k, [])
        return result
    }
    
    func sortColors(_ nums: inout [Int]) {
        func subSortColors(_ left: Int, _ right: Int) {
            if right <= left {
                return
            }
            let value = nums[right]
            var i: Int = left
            for j in left..<right {
                if nums[j] < value {
                    nums.swapAt(i, j)
                    i += 1
                }
            }
            nums[right] = nums[i]
            nums[i] = value
            subSortColors(left, i-1)
            subSortColors(i+1, right)
        }
        subSortColors(0, nums.count-1)
    }
    
    func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
        guard matrix.count > 0 && matrix.first!.count > 0 else {return false}
        //二分搜索行
        var lIdx = 0, rIdx = matrix.count - 1
        var mIdx = (lIdx + rIdx)/2
        while lIdx <= rIdx {
            mIdx = (lIdx + rIdx)/2
            let minV = matrix[mIdx].first!
            let maxV = matrix[mIdx].last!
            if minV <= target && maxV >= target {
                //目标值
                break
            }else if minV > target {
                rIdx = mIdx - 1
            }else {
                lIdx = mIdx + 1
            }
        }
        if lIdx > rIdx || mIdx < 0 || mIdx >= matrix.count {
            return false
        }
        //二分搜索列
        let usedSubArr = matrix[mIdx]
        lIdx = 0
        rIdx = usedSubArr.count - 1
        mIdx = (lIdx + rIdx)/2
        while lIdx <= rIdx {
            mIdx = (lIdx + rIdx)/2
            let v = usedSubArr[mIdx]
            if v == target {
                //目标值
                return true
            }else if v > target {
                rIdx = mIdx - 1
            }else {
                lIdx = mIdx + 1
            }
        }
        if lIdx > rIdx || mIdx < 0 || mIdx >= matrix.count {
            return false
        }
        return true
    }
    
    func setZeroes(_ matrix: inout [[Int]]) {
        guard !matrix.isEmpty && !matrix.first!.isEmpty else { return }
        var vZeroValue : Int?, hZeroValue : Int?
        for i in 0..<matrix.count {
            for j in 0..<matrix[i].count {
                if matrix[i][j] == 0 {
                    if i == 0 {
                        vZeroValue = 0
                    }else {
                        matrix[i][0] = 0
                    }
                    if j == 0 {
                        hZeroValue = 0
                    }else {
                        matrix[0][j] = 0
                    }
                }
            }
        }
        for i in 1..<matrix.count {
            for j in 1..<matrix[i].count {
                if matrix[i][0] == 0 || matrix[0][j] == 0 {
                    matrix[i][j] = 0
                }
            }
        }
        if vZeroValue == 0 {
            for i in 0..<matrix.first!.count {
                matrix[0][i] = 0
            }
        }
        if hZeroValue == 0 {
            for i in 0..<matrix.count {
                matrix[i][0] = 0
            }
        }
    }
    
    func simplifyPath(_ path: String) -> String {
        let line = "/"
        let pathArr = path.components(separatedBy: line)
        guard pathArr.count > 0 && pathArr.first!.count == 0 else {return path}
        var result = [String]()
        let dot1 = "."
        let dot2 = ".."
        for i in 1..<pathArr.count {
            let tmp = pathArr[i]
            if tmp.count > 0 && tmp != dot1 {
                if tmp == dot2 {
                    if result.count > 0 {
                        result.removeLast()
                    }
                }else {
                    result.append(tmp)
                }
            }
        }
        
        var resultStr = ""
        for str in result {
            resultStr.append(line)
            resultStr.append(str)
        }
        if resultStr.isEmpty {
            resultStr = line
        }
        return resultStr
    }
    
    func climbStairs(_ n: Int) -> Int {
        guard n > 0 else { return 0 }
        var dp = Array.init(repeating: 0, count: n+1)
        dp[0] = 1
        dp[1] = 1
        for i in 2..<dp.count {
            dp[i] = dp[i-1] + dp[i-2]
        }
        return dp.last!
    }
    
    func mySqrt(_ x: Int) -> Int {
        //二分查找
        var left = 0
        var right = x
        var result = x / 2
        while true {
            let square = result * result
            let square1 = (result + 1) * (result + 1)
            if square <= x && square1 >= x {
                if square1 == x { result = result + 1 }
                break
            }
            if square > x {
                right = result
            }else if(square1 < x) {
                left = result + 1
            }
            result = (left + right) / 2
        }
        return result
    }
    
    func addBinary(_ a: String, _ b: String) -> String {
        var result = [Character]()
        let aArr = Array(a)
        let bArr = Array(b)
        
        
        let zero:Character = "0"
        let one:Character = "1"
        
        var rOffset = 0
        var added = false
        while rOffset < aArr.count || rOffset < bArr.count {
            let aChar = rOffset < aArr.count ? aArr[aArr.count-rOffset-1] : zero
            let bChar = rOffset < bArr.count ? bArr[bArr.count-rOffset-1] : zero
            let charResult = (added ? 1:0) + (aChar == one ? 1:0) + (bChar == one ? 1:0)
            added = false
            switch charResult {
                case 2:
                    added = true
                    fallthrough
                case 0:
                    result = [zero] + result
                case 3:
                    added = true
                    fallthrough
                case 1:
                    result = [one] + result
                default: break
            }
            rOffset += 1
        }
        if added {
            result = [one] + result
        }
        return String(result)
    }
    
    func plusOne(_ digits: [Int]) -> [Int] {
        var result = [Int]()
        var tmp = 1
        var rIndex = digits.count - 1
        while tmp > 0 && rIndex >= 0 {
            let digit = digits[rIndex]
            var added = digit + tmp
            if added > 9 {
                tmp = 1
                added -= 10
            }else {
                tmp = 0
            }
            rIndex -= 1
            result = [added] + result
        }
        if tmp == 1 {
            result = [tmp] + result
        }else if(rIndex >= 0) {
            result = digits[0...rIndex] + result
        }
        return result
    }
    
    func minPathSum(_ grid: [[Int]]) -> Int {
        guard grid.count > 0 && grid.first!.count > 0 else {return 0}
        var dp = Array.init(repeating: Array.init(repeating: 0, count: grid.first!.count), count: grid.count)
        dp[0][0] = grid[0][0]
        for i in 1..<dp.count {
            dp[i][0] = dp[i-1][0] + grid[i][0]
        }
        for i in 1..<dp.first!.count {
            dp[0][i] = dp[0][i-1] + grid[0][i]
        }
        for x in 1..<dp.count {
            for y in 1..<dp.first!.count {
                dp[x][y] = grid[x][y] + min(dp[x-1][y], dp[x][y-1])
            }
        }
        return dp.last!.last!
    }
    
    func uniquePathsWithObstacles(_ obstacleGrid: [[Int]]) -> Int {
        guard obstacleGrid.count > 0 && obstacleGrid.first!.count > 0 && obstacleGrid.last!.last! == 0 else {return 0}
        var dp = Array.init(repeating: Array.init(repeating: 0, count: obstacleGrid.first!.count), count: obstacleGrid.count)
        for x in 0..<dp.count {
            for y in 0..<dp[x].count {
                if x == 0 && y == 0 {
                    dp[x][y] = 1
                    continue
                }
                dp[x][y] = ((x == 0 || obstacleGrid[x-1][y] == 1) ? 0 : dp[x-1][y]) + ((y == 0 || obstacleGrid[x][y-1] == 1) ? 0 :   dp[x][y-1])
            }
        }
        return dp.last!.last!
    }
    
    func uniquePaths(_ m: Int, _ n: Int) -> Int {
        var dp = Array.init(repeating: Array.init(repeating: 0, count: n), count: m)
        dp[0][0] = 1
        for i in 0..<dp.count {
            dp[i][0] = 1
        }
        for i in 0..<n {
            dp[0][i] = 1
        }
        for x in 1..<dp.count {
            for y in 1..<dp[x].count {
                dp[x][y] = dp[x-1][y] + dp[x][y-1]
            }
        }
        return dp[m-1][n-1]
    }
        
        
//        //每次都向右或者向下一步 超出范围结束
//        func tryNextStep(_ x:Int,_ y:Int) {
//            if x >= m || y >= n {
//                return
//            }
//            if x == m - 1 && y == n - 1 {
//                result += 1
//                return
//            }
//            tryNextStep(x+1, y)
//            tryNextStep(x, y+1)
//        }
//        tryNextStep(0, 0)
//        return result
//    }
    
    func rotateRight(_ head: ListNode?, _ k: Int) -> ListNode? {
        var tmpListNode: ListNode? = head
        var stepCount = 1
        while tmpListNode?.next != nil {
            stepCount += 1
            tmpListNode = tmpListNode?.next
        }
        tmpListNode?.next = head
        
        var preNode: ListNode? = head
        let usedCount = stepCount - k%stepCount - 1
        for _ in 0..<usedCount {
            preNode = preNode?.next
        }
        
        let reultNode = preNode?.next
        preNode?.next = nil
        return reultNode
    }
    
    func lengthOfLastWord(_ s: String) -> Int {
        let sArr = Array(s)
        var count = 0
        for (_ ,value) in sArr.enumerated().reversed() {
            if value == " " {
                if count > 0 {
                    break
                }
            }else {
                count += 1
            }
        }
        return count
    }
    
    
    func insert(_ intervals: [[Int]], _ newInterval: [Int]) -> [[Int]] {
        guard intervals.count > 0 else { return [newInterval]}
        if newInterval.last! < intervals.first!.first! {
            return [newInterval] + intervals
        }
        if newInterval.first! > intervals.last!.last! {
            return intervals + [newInterval]
        }
        
        var lIdx = 0, rIdx = intervals.count - 1
        //定义lIdx为小于新区间的最大左 rIdx为大于新区间右的最小右
        while intervals[lIdx].last! < newInterval.first! {
            lIdx += 1
        }
        while intervals[rIdx].first! > newInterval.last! {
            rIdx -= 1
        }
        
        var result = [[Int]]()
        
        if lIdx > 0 {
            result += intervals[0..<lIdx]
        }
        
        if lIdx > rIdx {
            result.append(newInterval)
        }else {
            var tmp = [Int]()
            tmp.append(min(intervals[lIdx].first!, newInterval.first!))
            tmp.append(max(intervals[rIdx].last!, newInterval.last!))
            result.append(tmp)
        }
        
        if rIdx < intervals.count - 1 {
            result += intervals[rIdx+1..<intervals.count]
        }
        return result
    }
    
    func merge(_ intervals: [[Int]]) -> [[Int]] {
        guard intervals.count > 0 else {
            return [[Int]]()
        }
        
        let usedIntervals = intervals.sorted { arr1, arr2 in
            if let value1 = arr1.first, let value2 = arr2.first {
                return value1 < value2
            }
            return false
        }
        var result = [[Int]]()
        
        var left = Int.min
        var right = Int.min
        for arr in usedIntervals {
            guard arr.count == 2 else { return [[Int]]()}
            let first = arr.first!
            let last = arr.last!
            guard last >= first else { return[[Int]]()}
            if first > right {
                //一个区间
                if left != Int.min {
                    result.append([left,right])
                }
                left = first
                right = last
            }else {
                if last > right {
                    right = last
                }
            }
        }
        if left != Int.min {
            result.append([left,right])
        }
        return result
    }
    
    func canJump(_ nums: [Int]) -> Bool {
        var index = 0
        while index < nums.count {
            let value = nums[index]
            if value + index >= nums.count - 1 {
                return true
            }
            if value <= 0 {
                return false
            }
            var maxOffSet = -1
            var maxIndex = 0
            for i in 1...value {
                let tmpValue = i + nums[i + index]
                if tmpValue >= maxOffSet {
                    maxOffSet = tmpValue
                    maxIndex = i + index
                }
            }
            if maxOffSet <= 0 {
                return false
            }
            index = maxIndex
        }
        return true
    }

    
    func maxSubArray(_ nums: [Int]) -> Int {
        guard nums.count > 0 else {
            return 0
        }
 
        var maxValue = nums.first!
        var preAdd = maxValue
        var rightIndex = 1
        while rightIndex < nums.count {
            //右每次都要增加1 左尽可能大
            let rightValue = nums[rightIndex]
            if preAdd < 0 {
                preAdd = 0
            }
            preAdd += rightValue
            maxValue = max(maxValue, preAdd)
            rightIndex += 1
        }
        return maxValue
    }
    
    func myPow(_ x: Double, _ n: Int) -> Double {
        if x == 0 {return 0}
        if n == 0 {return 1}
        let usedN = abs(n)
        var result = 1.0
        func generateMaxNValue(_ leaveN:Int) {
            guard leaveN > 0 else {return}
            var tmpN = 1
            var tmpValue = x
            while tmpN + tmpN <= leaveN {
                tmpN = tmpN + tmpN
                tmpValue = tmpValue * tmpValue
            }
            result *= tmpValue
            generateMaxNValue(leaveN-tmpN)
        }
        generateMaxNValue(usedN)
        if n < 0 {
            result = 1/result
        }
        return result
    }
    
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        var maps = [String:[String]]()
        func hashStr(_ str:String) -> String {
            return String(Array(str).sorted())
        }
        for str in strs {
            let key = hashStr(str)
            maps[key, default: []].append(str)
        }
        return [[String]](maps.values)
    }
    
    func rotate(_ matrix: inout [[Int]]) {
        guard matrix.count > 1 && matrix.first!.count == matrix.count else {return}
        let n = matrix.count - 1
        for row in 0..<matrix.count/2 {
            for i in row..<matrix.count-row-1 {
                //四个坐标内容交换
                (matrix[i][n-row],
                 matrix[n-row][n-i],
                 matrix[n-i][row],
                 matrix[row][i])
                =
                (matrix[row][i],
                 matrix[i][n-row],
                 matrix[n-row][n-i],
                 matrix[n-i][row])
            }
        }
    }
    
    func permuteUnique(_ nums: [Int]) -> [[Int]] {
        var result = [[Int]]()
        func generateNext(with leaveNums: [Int],_ preResult:[Int]) {
            if leaveNums.isEmpty {
                result.append(preResult)
                return
            }
            var maps = [Int:Int]()
            for (i,value) in leaveNums.enumerated() {
                if maps[value] == 1 {
                    continue
                }
                maps[value] = 1
                var usedLeaveNums = Array(leaveNums)
                usedLeaveNums.remove(at: i)
                let usedPreResult = preResult + [value]
                generateNext(with: usedLeaveNums, usedPreResult)
            }
        }
        generateNext(with: nums, [])
        return result
    }
    
    func jump(_ nums: [Int]) -> Int {
        if nums.isEmpty {
            return 0
        }
        if nums.count == 1 {
            return 0
        }
        var originIndex = 0
        var index = 0
        var step = 0
        while index < nums.count {
            let indexValue = nums[index]
            guard indexValue + index < nums.count - 1 else {return step + 1}
            var maxValue = 0
            for i in index+1...index+indexValue {
                let offValue = nums[i] + i
                if offValue  > maxValue {
                    maxValue = offValue
                    index = i
                }
            }
            if originIndex == index {
                return 0
            }else {
                originIndex = index
            }
            step += 1
        }
        return step
    }
    
//    func firstMissingPositive(_ nums: [Int]) -> Int {
//        var usedNums = nums
//
//        for i in 0..<usedNums.count {
//            let value = usedNums[i]
//        }
//        let usedNums = nums.sorted()
//        var index = 0
//        var value = 1
//        while index < usedNums.count {
//            if usedNums[index] < value {
//                index += 1
//            }else if usedNums[index] == value{
//                value += 1
//                index += 1
//            }else {
//                return value
//            }
//        }
//        return value
//    }
    
    
//    func combinationSum2(_ candidates: [Int], _ target: Int) -> [[Int]] {
//        var candidatesMap = [Int:Int]()
//        for key in candidates {
//            candidatesMap[key] = (candidatesMap[key] ?? 0) + 1
//        }
//        let allKeys = Array(candidatesMap.keys).sorted()
//        var result = [[Int]]()
//        func subSumResult(_ subTarget: Int, _ preResultArr:[Int], _ keyIndex:Int) {
//            guard subTarget > 0 && allKeys.count > keyIndex else {
//                return
//            }
//            let key = allKeys[keyIndex]
//            subSumResult(subTarget, preResultArr, keyIndex+1)
//
//
//            var tmpArr = preResultArr
//            tmpArr.append(key)
//            if let count = candidatesMap[key] {
//                for i in 1...count {
//                    let offSet = key * i
//                    if offSet == subTarget {
//                        result.append(tmpArr)
//                    }else if offSet < subTarget {
//                        subSumResult(subTarget-offSet, tmpArr,keyIndex+1)
//                    }else {
//                        break
//                    }
//                    tmpArr.append(key)
//                }
//            }
//        }
//        subSumResult(target, [], 0)
//        return result
//    }

    
    func combinationSum2(_ tempCandidates: [Int], _ target: Int) -> [[Int]] {
        let candidates = tempCandidates.sorted()
        var result = [[Int]]()
        func subSumResult(_ subTarget: Int, _ preResultArr:[Int],_ start: Int) {
            guard subTarget > 0 && start < candidates.count else {
                return
            }
            var offSet = 0
            while start + offSet + 1 < candidates.count && candidates[start] == candidates[start + offSet + 1] {
                offSet += 1
            }
            subSumResult(subTarget, preResultArr, start+offSet+1)
            let cuC = candidates[start]
            var tmpArr = preResultArr
            for i in 1...offSet+1 {
                let offSetValue = cuC * i
                tmpArr.append(cuC)
                if offSetValue == subTarget {
                    result.append(tmpArr)
                }else if(offSetValue < subTarget) {
                    subSumResult(subTarget-offSetValue, tmpArr, start+offSet+1)
                }else {
                    break
                }
            }
        }
        subSumResult(target, [], 0)
        return result
    }
    
    func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
        var result = [[Int]]()
        func subSumResult(_ subTarget: Int, _ preResultArr:[Int],_ start: Int) {
            guard subTarget > 0 && start < candidates.count else {
                return
            }
            subSumResult(subTarget, preResultArr, start+1)
            let cuC = candidates[start]
            var offSet = cuC
            var tmpArr = preResultArr
            tmpArr.append(cuC)
            while offSet <= subTarget {
                if offSet == subTarget {
                    result.append(tmpArr)
                }else {
                    subSumResult(subTarget-offSet, tmpArr, start+1)
                    tmpArr.append(cuC)
                }
                offSet += cuC
            }
        }
        subSumResult(target, [], 0)
        return result
    }
    
    
    func countAndSay(_ n: Int) -> String {
        var arr : Array<Int> = [1]
        func generateNext(_ orginArr:Array<Int>) -> Array<Int> {
            var resultArr = [Int]()
            var index = 0
            var count = 1
            while index < orginArr.count {
                if index < orginArr.count - 1 && orginArr[index] == orginArr[index+1] {
                    count += 1
                }else {
                    resultArr.append(count)
                    resultArr.append(arr[index])
                    count = 1
                }
                index += 1
            }
            return resultArr
        }
        
        for _ in 1..<n {
            arr = generateNext(arr)
        }
        var str = ""
        for (_,value) in arr.enumerated()
        {
            str.append(String(value))
        }
        return str
    }
    
    func solveSudoku(_ board: inout [[Character]]) {

    }
    
    
    func isValidSudoku(_ board: [[Character]]) -> Bool {
        var hasRow = [Set<Character>](repeating: Set<Character>(), count: board.count)
        var hasCol = [Set<Character>](repeating: Set<Character>(), count: board[0].count)
        var hasGrid = [Set<Character>](repeating: Set<Character>(), count: 9)
        for (i,row) in board.enumerated() {
            for (j,ele) in row.enumerated() {
                if ele == "." {
                    continue
                }
                if hasRow[i].contains(ele) {
                    return false
                }
                if hasCol[j].contains(ele) {
                    return false
                }
                let girdIndex = i/3 + j/3 * 3;
                if hasGrid[girdIndex].contains(ele) {
                    return false
                }
                hasRow[i].insert(ele)
                hasCol[j].insert(ele)
                hasGrid[girdIndex].insert(ele)
            }
        }
        return true
    }
    
    func searchInsert(_ nums: [Int], _ target: Int) -> Int {
        if nums.isEmpty {
            return -1
        }
        var lIdx = 0 , rIdx = nums.count - 1
        if nums[rIdx] < target {
            return nums.count
        }
        if nums[lIdx] > target {
            return 0
        }
        while lIdx <= rIdx && rIdx < nums.count && lIdx >= 0 {
            let mid = (lIdx + rIdx + 1) / 2
            if nums[mid] == target {
                return mid
            }
            if nums[mid] > target {
                rIdx = mid - 1
                if nums[rIdx] < target {
                    return mid
                }
            }else {
                lIdx = mid + 1
                if nums[lIdx] > target {
                    return lIdx
                }
            }
        }
        return rIdx
    }
    
    
    func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
        var lIdx = 0, rIdx = nums.count - 1
        while lIdx <= rIdx {
            let mid = (lIdx + rIdx + 1) / 2
            if nums[mid] == target {
                (lIdx,rIdx) = (mid,mid)
                while lIdx > 0 && nums[lIdx-1] == target {
                    lIdx -= 1
                }
                while rIdx < nums.count - 1 && nums[rIdx+1] == target {
                    rIdx += 1
                }
                return [lIdx, rIdx]
            }
            if target > nums[mid] {
                lIdx = mid + 1
            }else {
                rIdx = mid - 1
            }
        }
        return [-1, -1]
    }
    
    
    func search(_ nums: [Int], _ target: Int) -> Int {

        if nums.count == 0 {
            return -1
        }
        
        var lIdx = 0, rIdx = nums.count - 1
        
        while lIdx <= rIdx {
            let mid = (lIdx + rIdx + 1)/2
            if nums[mid] == target {
                return mid
            }
            //每次判断是在左边还是右边
            if nums[lIdx] < nums[mid] {
                if nums[lIdx] <= target && nums[mid] > target {
                    rIdx = mid - 1
                }else {
                    lIdx = mid + 1
                }
            }else {
                if nums[mid] < target && nums[rIdx] >= target {
                    lIdx = mid + 1
                }else {
                    rIdx = mid - 1
                }
            }
        }
        return -1
    }
    
    
    func longestValidParentheses(_ s: String) -> Int {
        let sArr = Array(s)
        var maxCount = 0
        var stack = [Int]()
        stack.append(-1)
        for (i,value) in sArr.enumerated() {
            if value == "(" {
                stack.append(i)
            } else {
                stack.removeLast()
                if stack.isEmpty {
                    stack.append(i)
                } else {
                    maxCount = max(maxCount,i - stack.last!)
                }
            }
        }
        return maxCount
    }
    
    func nextPermutation(_ nums: inout [Int]) {
        if nums.count <= 1 {
           return
        }
        
        var index = nums.count - 2
        while index >= 0 && nums[index] >= nums[index+1] {
            index -= 1
        }
        if index < 0 {
            nums = nums.reversed()
            return
        }
        var rightIndex = index + 1
        while rightIndex < nums.count && nums[rightIndex] > nums[index] {
            rightIndex += 1
        }
        rightIndex -= 1
        if index >= 0 {
            nums.swapAt(index, rightIndex)
        }
        nums = nums[...index] + nums[index+1..<nums.count].reversed()
    }
    
    
//    func findSubstring(_ s: String, _ words: [String]) -> [Int] {
//
//        var dicts:[String:Int] = [:]
//        for w in words {
//            dicts[w, default:0] += 1
//        }
//
//        var result = [Int]()
//        let singleLen = words[0].count
//        let totalLen = words.count * singleLen
//        let cArray = Array(s)
//
//        for i in 0..<singleLen {
//            var start = i
//            while start + totalLen <= cArray.count {
//                var mDicts = dicts
//                var curLen = 0
//                let end = start + totalLen
//                while curLen < totalLen {
//                    let str = String(cArray[end-curLen-singleLen..<end-curLen])
//                    if let val = mDicts[str] {
//                        if val > 0 {
//                            curLen += singleLen
//                            mDicts[str] = val - 1
//                            continue
//                        }
//                    }
//                    break
//                }
//                if curLen == totalLen {
//                    result.append(start)
//                    start += singleLen
//                } else {
//                    start = end - curLen
//                }
//            }
//        }
//        return result
//   }

    
    func subString(_ s:String ,_ startIndex:Int,_ length:Int) -> String? {
        if startIndex + length > s.count || startIndex < 0 {
            return nil
        }
        let start = s.index(s.startIndex, offsetBy: startIndex)
        let end = s.index(s.startIndex, offsetBy: startIndex + length)
        let subS = String(s[start..<end])
        return subS
    }
    
    
    func findSubstring(_ s: String, _ words: [String]) -> [Int] {
        if s.count == 0 || words.count == 0 {
            return []
        }
        let lent = words.first!.count
        let wordsCount = words.count * lent
        if s.count < wordsCount {
            return []
        }
        var wordMaps = [String:Int]()
        for str in words {
            let count = wordMaps[str] ?? 0
            wordMaps[str] = count + 1
        }
        var result = [Int]()
        
        let sArr = Array(s)
        for x in 0..<lent {
            var tmpMaps = wordMaps
            var left = x
            while left + wordsCount <= sArr.count {
                for y in stride(from: left, to: left + wordsCount, by: lent).reversed() {
                    let subS = String(sArr[y..<y+lent])
                    let cCount = tmpMaps[subS] ?? 0
                    if cCount == 0 {
                        left = y + lent
                        tmpMaps = wordMaps
                        break
                    }else if cCount == 1 {
                        tmpMaps[subS] = nil
                    }else {
                        tmpMaps[subS] = cCount - 1
                    }
                    if y == left {
                        result.append(y)
                        left += lent
                        tmpMaps = wordMaps
                    }
                }
            }
        }
        return result
    }
    
//    func findSubstring(_ s: String, _ words: [String]) -> [Int] {
//        if s.count == 0 || words.count == 0 {
//            return []
//        }
//        let lent = words.first!.count
//        let wordsCount = words.count * lent
//        if s.count < wordsCount {
//            return []
//        }
//        var wordMaps = [String:Int]()
//        for str in words {
//            let count = wordMaps[str] ?? 0
//            wordMaps[str] = count + 1
//        }
//
//        var result = [Int]()
//        for i in 0...s.count-wordsCount {
//            var tmpMaps = wordMaps
//            for j in 0..<words.count {
//                let startIndex = s.index(s.startIndex, offsetBy: i + j * lent)
//                let endIndex = s.index(s.startIndex, offsetBy: i + j * lent + lent)
//                let subS = String(s[startIndex..<endIndex])
//                let count = tmpMaps[subS] ?? 0
//                if count == 0 {
//                    break
//                }else if count == 1{
//                    tmpMaps[subS] = nil
//                }else {
//                    tmpMaps[subS] = count - 1
//                }
//            }
//            if tmpMaps.isEmpty {
//                result += [i]
//            }
//        }
//        return result
//    }

    func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
        //四数 固定 2个
        if nums.count < 4 {
            return []
        }
        let usedNums = nums.sorted()
        var result = [[Int]]()
        for i in 0..<usedNums.count - 3 {
            if i > 0 && usedNums[i] == usedNums[i - 1] {
                continue
            }
            for j in i+2..<usedNums.count {
                if j < usedNums.count - 1 && usedNums[j] == usedNums[j+1] {
                    continue
                }
                let needValue = target - (usedNums[i] + usedNums[j])
                var lIndex = i + 1;
                var rIndex = j - 1;
                while lIndex < rIndex {
                    let tmpValue = usedNums[lIndex] + usedNums[rIndex]
                    if tmpValue == needValue {
                        result += [[usedNums[i],usedNums[lIndex],usedNums[rIndex],usedNums[j]]]
                        while lIndex < rIndex && usedNums[lIndex] == usedNums[lIndex + 1] {
                            lIndex += 1
                        }
                        while lIndex < rIndex && usedNums[rIndex] == usedNums[rIndex - 1] {
                            rIndex -= 1
                        }
                        lIndex += 1
                        rIndex -= 1
                    }else if tmpValue < needValue {
                        while lIndex < rIndex && usedNums[lIndex] == usedNums[lIndex + 1] {
                            lIndex += 1
                        }
                        lIndex += 1
                    }else {
                        while lIndex < rIndex && usedNums[rIndex] == usedNums[rIndex - 1] {
                            rIndex -= 1
                        }
                        rIndex -= 1
                    }
                }
            }
        }
        return result
    }
    
    func letterCombinations(_ digits: String) -> [String] {
        if digits.isEmpty {
            return []
        }
        
        let numLetterMaps : [Character:[Character]] = [
            "2" : ["a","b","c"],
            "3" : ["d","e","f"],
            "4" : ["g","h","i"],
            "5" : ["j","k","l"],
            "6" : ["m","n","o"],
            "7" : ["p","q","r","s"],
            "8" : ["t","u","v"],
            "9" : ["w","x","y","z"]
        ]
        
        func subLetterCombinations(_ subDigits: [Character] ,_ preArr: [[Character]]) -> [[Character]] {
            var result = [[Character]]()
            if let char = subDigits.first {
                if let tmpArr = numLetterMaps[char] {
                    for i in 0..<tmpArr.count {
                        if preArr.count == 0 {
                            result += [[tmpArr[i]]]
                        }else {
                            for j in 0..<preArr.count {
                                let usedTmpArr = preArr[j] + [tmpArr[i]]
                                result += [usedTmpArr]
                            }
                        }
                    }
                }
            }
            
            let tmpSubDigits = Array(subDigits[1..<subDigits.count])
            if result.count == 0 {
                result = preArr
            }
            if tmpSubDigits.count > 0 {
                return subLetterCombinations(tmpSubDigits, result)
            }else {
                return result
            }
        }
        
        let usedResult = subLetterCombinations(Array(digits), [])
        var result = [String]()
        for tmp in usedResult {
            result += [String(tmp)]
        }
        return result
    }
    
    func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
        if nums.count < 3 {
            return Int.min
        }
        let usedNums = nums.sorted()
        var result = nums[0] + nums[1] + nums[2]
        for mIndex in 1..<usedNums.count-1 {
            var lIndex = mIndex - 1
            var rIndex = mIndex + 1
            var getResult = false
            while lIndex >= 0 && rIndex < usedNums.count {
                let value = usedNums[lIndex] + usedNums[rIndex] + usedNums[mIndex]
                if (abs(result - target) > abs(value - target)) {
                    result = value
                }
                if value < target {
                    rIndex += 1
                }else if(value > target) {
                    lIndex -= 1
                }else {
                    getResult = true
                    break
                }
            }
            if getResult {
                break
            }
        }
        return result
    }
    
//    func threeSum(_ nums: [Int]) -> [[Int]] {
//        if nums.count < 3 {
//            return []
//        }
//        let usedNums = nums.sorted()
//        var result:[[Int]] = []
//        var left = 0
//        var middle = 1
//        var right = usedNums.count - 1
//        while left < right - 1 {
//            while middle < right {
//                let value = usedNums[left] + usedNums[right] + usedNums[middle]
//                if value == 0 {
//                    result += [[usedNums[left],usedNums[middle],usedNums[right]]]
//                    left += 1
//                    right -= 1
//                    break
//                }else if(value > 0) {
//                    right -= 1
//                }else if(middle < right-1){
//                    middle+=1
//                }else {
//                    left += 1
//                    middle = left + 1
//                    break
//                }
//            }
//        }
//        return result
//    }
    
    
    func threeSum(_ nums: [Int]) -> [[Int]] {
        if nums.count < 3 {
            return []
        }
        let usedNums = nums.sorted { num1, num2 in
            return num2 > num1
        }
        var result:[[Int]] = []
        for leftI in 0..<usedNums.count - 2 {
            if leftI > 0 && usedNums[leftI] == usedNums[leftI-1] {
                continue
            }
            let needValue = -usedNums[leftI]
            var middleI = leftI+1
            var rightI = usedNums.count-1
            while middleI < rightI {
                let checkValue = usedNums[middleI] + usedNums[rightI]
                if checkValue == needValue {
                    let usedArr = [usedNums[leftI],usedNums[middleI],usedNums[rightI]]
                    result += [usedArr]
                    while middleI < rightI && usedNums[middleI] == usedNums[middleI+1] {
                        middleI += 1
                    }
                    middleI += 1
                    while middleI < rightI && usedNums[rightI] == usedNums[rightI-1] {
                        rightI -= 1
                    }
                    rightI -= 1
                }else if checkValue > needValue {
                    rightI -= 1
                }else {
                    middleI += 1
                }
            }
        }
        return result
    }

    
    func longestCommonPrefix(_ strs: [String]) -> String {
        if strs.count == 0 {
            return ""
        }
        var index = 0
        var getResult = false
        var char : Character?
        var result : Array<Character> = []
        while !getResult {
            for str in strs {
                if str.count > index {
                    let temp = str[str.index(str.startIndex, offsetBy: index)]
                    if char == nil {
                        char = temp
                    }else if char != temp {
                        getResult = true
                        break
                    }
                }else {
                    getResult = true
                    break
                }
            }
            if let usedC = char, getResult == true {
                result += [usedC]
            }else {
                getResult = true
            }
            char = nil
            index += 1
        }
        return String(result)
    }
    
    func romanToInt(_ s: String) -> Int {
        let valueArr = [1,5,10,50,100,500,1000]
        let keyArr : Array<Character> = ["I","V","X","L","C","D","M"]
        var result = 0
        let sArr = Array(s)
        var rIndex = keyArr.count - 1
        var sIndex = 0
        
        while rIndex >= 0 && sIndex < sArr.count {
            let dealIndex = (rIndex - 1)/2 * 2
            if sArr[sIndex] == keyArr[rIndex] {
                result = result + valueArr[rIndex]
                sIndex += 1
            }else if rIndex > 0 && sIndex < sArr.count - 1 && sArr[sIndex] == keyArr[dealIndex] && sArr[sIndex+1] == keyArr[rIndex] {
                result = result + valueArr[rIndex] - valueArr[dealIndex]
                sIndex += 2
                rIndex -= 1
            }else {
                rIndex -= 1
            }
        }
        return result
    }
    
    func intToRoman(_ num: Int) -> String {
        let valueArr = [1,5,10,50,100,500,1000]
        let keyArr : Array<Character> = ["I","V","X","L","C","D","M"]
        var rightIndex = keyArr.count - 1
        var usedStr : Array<Character> = []
        var leaveNum = num
        while rightIndex >= 0 {
            let symbol = keyArr[rightIndex]
            let value = valueArr[rightIndex]
            //先处理整的
            let count = leaveNum / value
            leaveNum = leaveNum % value
            if count > 0 {
                usedStr += Array.init(repeating: symbol, count: count)
            }
            //再处理左边的情况
            if rightIndex > 0 {
                let dealIndex = ((rightIndex - 1) / 2) * 2
                let dealSymbol = keyArr[dealIndex]
                let dealValue = value - valueArr[dealIndex]
                if leaveNum >= dealValue {
                    usedStr += [dealSymbol,symbol]
                    leaveNum -= dealValue
                }
            }
            rightIndex -= 1
        }
        return String(usedStr)
    }
    
    func maxArea(_ height: [Int]) -> Int {
        var left = 0
        var right = height.count - 1
        var maxArea = 0
        while left < right {
            let high = min(height[left], height[right])
            let temp = (right - left) * high
            maxArea = max(temp, maxArea)
            if height[left] < height[right] {
                left += 1
            }else {
                right -= 1
            }
        }
        return maxArea
    }
    
    func isMatch(_ s: String, _ p: String) -> Bool {
        if p.count < 1 {
            return false
        }
        let pArr = Array(p)
        let sArr = Array(s)
        var dp: [[Bool]] = Array.init(repeating: Array.init(repeating: false, count: s.count+1), count: p.count+1)
        dp[0][0] = true
        for i in 1...pArr.count {
            let pChar = pArr[i-1]
            let preP = pChar == "*" ? (i > 1 ? pArr[i - 2] : nil) : nil
            if i < pArr.count && pArr[i] == "*" {
                //如果后面是* 这一轮不处理
                continue
            }
            if preP != nil {
                dp[i][0] = dp[i-2][0]
            }
            for j in 1...sArr.count {
                let sChar = sArr[j-1]
                if preP != nil {
                    dp[i][j] = dp[i-2][j] || (dp[i][j-1] && (preP == "." || preP == sChar))
                }else {
                    dp[i][j] = dp[i-1][j-1] && (pChar == "." || pChar == sChar)
                }
            }
        }
        return dp[pArr.count][sArr.count]
    }
    
    func reverse(_ x: Int) -> Int {
        var result = 0
        var left = x
        while left != 0 {
            result = result * 10 + left % 10;
            if result > Int32.max || result < Int32.min {
                return 0
            }
            left /= 10
        }
        return result
    }
    
    func myAtoi(_ s: String) -> Int {
        var result = 0
        var isNeg = -1
        for char in s {
        
            if isNeg == -1 && char == " "{
                
            }else if char == "-" || char == "+" {
                if isNeg != -1 {
                    break
                }
                if char == "-" {
                    isNeg = 1
                }else {
                    isNeg = 0
                }
            }else if let value = char.wholeNumberValue {
                if isNeg == -1 {
                    isNeg = 0
                }
                result = result * 10 + (isNeg == 1 ? -value : value)
                if result < Int32.min {
                    result = Int(Int32.min)
                    break
                }
                if result > Int32.max {
                    result = Int(Int32.max)
                    break
                }
            }else {
                break
            }
        }
        return result
     }
    
    
    func convert(_ s: String, _ numRows: Int) -> String {
        if numRows <= 1 || numRows >= s.count {
            return s
        }
        let sArr = Array(s)
        var usedArr: Array<Character> = []
        let per = numRows + numRows - 2
        let perRow = (sArr.count + per - 1) / per
        
        for x in 0...perRow {
            let origin = x * per
            if origin < sArr.count {
                usedArr.append(sArr[origin])
            }
        }
        for y in 1..<numRows-1 {
            for x in 0...perRow {
                let origin1 = x * per + y
                let origin2 = (x + 1) * per - y
                if origin1 < sArr.count {
                    usedArr.append(sArr[origin1])
                }
                if origin2 < sArr.count {
                    usedArr.append(sArr[origin2])
                }
            }
        }
        for x in 0...perRow {
            let origin3 = numRows - 1 + x * per
            if origin3 < sArr.count {
                usedArr.append(sArr[origin3])
            }
        }
        return String(usedArr)
    }

    func findArrayPalindromeDeep (_ arr: Array<Character>, _ center: Int) -> (Int,Bool) {
        //自己为中心 或者向上一位同为中心
        var result = (0,false)
        let upper = min(center, arr.count-center-1)
        if upper >= 1 {
            for i in 1...upper {
                let left = arr[center-i]
                let right = arr[center + i]
                if left == right {
                    result.0 = max(i, result.0)
                }else {
                    break
                }
            }
        }
        let upper2 = min(center, arr.count-center-2)
        if upper2 >= 0 {
            for i in 0...upper2 {
                let left = arr[center-i]
                let right = arr[center+i+1]
                if left == right{
                    if i >= result.0 {
                        result.1 = true
                        result.0 = i
                    }
                }else {
                    break
                }
            }
        }
        return result
    }
    
    func longestPalindrome(_ s: String) -> String {
        let arr = Array(s)
        var index = (0,false,0)
        for i in 0..<arr.count {
            let tmp = self.findArrayPalindromeDeep(arr, i)
            if tmp.0 > index.0 {
                index.0 = tmp.0
                index.1 = tmp.1
                index.2 = i
            }else if tmp.0 == index.0 && tmp.1 && !index.1 {
                index.1 = tmp.1
                index.2 = i
            }
        }
        var result : Array<Character>
        if index.1 {
            result = Array(arr[index.2-index.0...index.2+index.0+1])
        }else {
            result = Array(arr[index.2-index.0...index.2+index.0])
        }
        return String(result)
//        var left = 0
//        var right = 0
//        while right < arr.count {
//            if self.checkArrayPalindrome(arr, left, right) {
//                right += 1
//            }else {
//                let rightPalindrome = self.checkArrayPalindrome(arr, left, right + 1)
//                if rightPalindrome {
//                    right += 2
//                }else {
//                    let length = right - left - 1
//                    if length >= result.count {
//                        result = Array(arr[left...(right-1)])
//                    }
//                    left += 1
//                    right = left
//                }
//            }
//        }
//        if right - left - 1 >= result.count && self.checkArrayPalindrome(arr, left, right - 1) {
//            result = Array(arr[left...(right-1)])
//        }
//        return String(result)
    }
    
    func checkArrayPalindrome(_ arr: Array<Character>, _ left: Int, _ right:Int) -> Bool {
        if right > arr.count - 1 {
            return false
        }
        if left < 0 {
            return false
        }
        for i in left...((right-left)/2 + left) {
            if arr[i] != arr[right - (i - left)] {
                return false
            }
        }
        return true
    }

    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        let allCount = nums1.count + nums2.count
        let midIndex = allCount / 2
        var index1 = 0
        var leftIndex1 = 0
        var rightIndex1 = nums1.count
        var index2 = midIndex - index1
        if index2 > nums2.count {
            index2 = nums2.count
            if index2 < 0 {
                index2 = 0
            }
            index1 = midIndex - index2
        }
        var isResult = false
        while !isResult {
            let left1 = index1 - 1 >= 0 ? nums1[index1 - 1] : Int.min
            let right1 = index1 < nums1.count ? nums1[index1] : Int.max
            let left2 = index2 - 1 >= 0 ? nums2[index2 - 1] : Int.min
            let right2 = index2 < nums2.count ? nums2[index2] : Int.max
            if left1 <= right2 && right1 >= left2 {
                isResult = true
            }else {
                if left1 > right2 {
                    rightIndex1 = index1;
                    let tmp = leftIndex1 + (index1 - leftIndex1)/2;
                    if tmp >= index1 {
                        index1 -= 1;
                    }else {
                        index1 = tmp;
                    }
                }else if right1 < left2 {
                    leftIndex1 = index1;
                    let tmp = (rightIndex1 - index1)/2 + index1
                    if tmp <= index1 {
                        index1 += 1
                    }else {
                        index1 = tmp
                    }
                }
                if index1 < 0 {
                    index1 = 0
                }
                if index1 > nums1.count {
                    index1 = nums1.count
                }
                index2 = midIndex - index1
                if index2 < 0 {
                    index2 = 0
                    index1 = midIndex - index2
                }
            }
        }
        let isEven = allCount % 2 == 0
        var result:Double = 0
        let left1 = index1 - 1 >= 0 ? nums1[index1 - 1] : Int.min
        let right1 = index1 < nums1.count ? nums1[index1] : Int.max
        let left2 = index2 - 1 >= 0 ? nums2[index2 - 1] : Int.min
        let right2 = index2 < nums2.count ? nums2[index2] : Int.max
        if isEven {
            result = (Double(max(left1, left2)) + Double(min(right1, right2))) * 0.5
        }else {
            result = Double(min(right1, right2))
        }
        return result
    }
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

