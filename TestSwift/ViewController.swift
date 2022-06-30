//
//  ViewController.swift
//  TestSwift
//
//  Created by  joy on 2022/5/31.
//

import UIKit

public class TreeNode {
   public var val: Int
   public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
       self.right = right
   
    }
}


 public class ListNode {
     public var val: Int
     public var next: ListNode?
     public init() { self.val = 0; self.next = nil; }
     public init(_ val: Int) { self.val = val; self.next = nil; }
     public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
 }
 

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let node = ListNode(1)
//        node.next = ListNode(2)
//        node.next?.next = ListNode(3)
//
//        let result = self.reverseKGroup(node,2)
//
//
//        print(result?.val ?? "")
        
//        var arr = [1,1,2]
//        print(self.removeDuplicates(&arr))
  
        // Do any additional setup after loading the view.
    }
    
    
    
    func divide(_ dividend: Int, _ divisor: Int) -> Int {
        if divisor == 0 {
            return Int(Int32.max)
        }
        if dividend == 0 || divisor == 1 {
            return dividend
        }
        if divisor == -1 {
            if dividend <= Int32.min {
                return Int(Int32.max)
            }
            return -dividend
        }
        
        let usedDividend = abs(dividend)
        let usedDivisor = abs(divisor)
        
        var leaveDividend = usedDividend
        var cuDivisorArr = [usedDivisor]
        var cuCountArr = [1]
        var allCount = 0
        while leaveDividend >= usedDivisor {
            let currentDivisor = cuDivisorArr.last!
            let currentCount = cuCountArr.last!
            if leaveDividend > currentDivisor + currentDivisor {
                cuDivisorArr += [currentDivisor + currentDivisor]
                cuCountArr += [currentCount + currentCount]
            }else if (leaveDividend < currentDivisor) {
                cuDivisorArr.removeLast()
                cuCountArr.removeLast()
            }else {
                leaveDividend -= currentDivisor
                allCount += currentCount
            }
        }
        let isNeg = dividend < 0 && divisor > 0 || dividend > 0 && divisor < 0
        let result = isNeg ? -allCount : allCount
        return result
    }
    
    func strStr(_ haystack: String, _ needle: String) -> Int {
        if haystack.count < needle.count {
            return -1
        }
        var fitIndex = -1
        for i in 0...(haystack.count - needle.count) {
            var fit = true
            for j in 0..<needle.count {
                let hChar = haystack[haystack.index(haystack.startIndex, offsetBy: i+j)]
                let nChar = needle[needle.index(needle.startIndex, offsetBy: j)]
                if hChar != nChar {
                    fit = false
                    break
                }
            }
            if fit {
                fitIndex = i
                break
            }
        }
        return fitIndex
    }
    
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        var offset = 0
        for i in 1..<nums.count {
            if nums[i] == val {
                offset += 1
            }else if offset > 0 {
                nums[i-offset] = nums[i]
            }
        }
        return nums.count - offset
    }
    
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        var offset = 0
        for i in 1..<nums.count {
            if nums[i] == nums[i-offset-1] {
                offset += 1
            }else if offset > 0 {
                nums[i-offset] = nums[i]
            }
        }
        return nums.count - offset
    }
    
    func reverseKGroup(_ head: ListNode?, _ k: Int) -> ListNode? {
        if k <= 1 {
            return head
        }
        let preNode = ListNode()
        preNode.next = head
        var cuNode : ListNode? = preNode
        while cuNode != nil {
            //先判断该循环可行
            var tmpNode : ListNode? = cuNode
            for _ in 0..<k {
                tmpNode = tmpNode?.next
                if tmpNode == nil {
                    break
                }
            }
            guard tmpNode != nil else {
                break
            }
            
            tmpNode = cuNode?.next
            for _ in 1..<k {
                let dNode = tmpNode?.next?.next
                tmpNode?.next?.next = cuNode?.next
                cuNode?.next = tmpNode?.next
                tmpNode?.next = dNode
            }
            cuNode = tmpNode
        }
        return preNode.next
    }
    
    func swapPairs(_ head: ListNode?) -> ListNode? {
        let preNode = ListNode()
        preNode.next = head
        var cuNode : ListNode? = preNode
        while cuNode?.next != nil && cuNode?.next?.next != nil {
            let tmpNode = cuNode?.next
            cuNode?.next = cuNode?.next?.next
            tmpNode?.next = cuNode?.next?.next
            cuNode?.next?.next = tmpNode
            cuNode = tmpNode
        }
        return preNode.next
    }
    
    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        if lists.isEmpty {
            return nil
        }
        let preNode = ListNode()
        var cuNode :ListNode? = preNode
        var usedLists: [ListNode?] = lists
        usedLists.removeAll { $0 == nil }
        func findNextSmall() {
            guard usedLists.count > 0 else {return}
            var tmpNode : ListNode?
            var index = -1
            for (i,value) in usedLists.enumerated().reversed() {
                if tmpNode == nil || (value?.val != nil && tmpNode!.val < value!.val) {
                    tmpNode = value
                    index = i
                }
            }
            if tmpNode != nil {
                usedLists.remove(at: index)
            }else {
                usedLists[index] = tmpNode?.next
            }
            cuNode?.next = tmpNode
            cuNode = cuNode?.next
            findNextSmall()
        }
        findNextSmall()
        return preNode.next
    }
    //对链表数组进行排序 取最小的
    
    
    func generateParenthesis(_ n: Int) -> [String] {
        var result = [String]()
        func subGenerateParenthesis(_ leftC:Int,_ rightC:Int,_ subS:String) {
            guard leftC <= n ,rightC <= n, leftC >= rightC else {
                return
            }
            if leftC == n && rightC == n {
                result += [subS]
            }
            subGenerateParenthesis(leftC + 1, rightC, subS + "(")
            subGenerateParenthesis(leftC, rightC + 1, subS + ")")
        }
        subGenerateParenthesis(0, 0, "")
        return result
    }
    
    func mergeTwoLists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
        let preNode = ListNode()
        var currentNode: ListNode? = preNode
        var node1 = list1
        var node2 = list2
        while node1 != nil && node2 != nil {
            if node1!.val < node2!.val {
                currentNode?.next = node1
                node1 = node1?.next
                currentNode = currentNode?.next
            }else {
                currentNode?.next = node2
                node2 = node2?.next
                currentNode = currentNode?.next
            }
        }
        currentNode?.next = node1 != nil ?  node1 : node2
        return preNode.next
    }
    


}

