/*
* Copyright (C) 2015 - 2017, Daniel Dahan and CosmicMind, Inc. <http://cosmicmind.com>.
* All rights reserved.
*
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions are met:
*
*	*	Redistributions of source code must retain the above copyright notice, this
*		list of conditions and the following disclaimer.
*
*	*	Redistributions in binary form must reproduce the above copyright notice,
*		this list of conditions and the following disclaimer in the documentation
*		and/or other materials provided with the distribution.
*
*	*	Neither the name of CosmicMind nor the names of its
*		contributors may be used to endorse or promote products derived from
*		this software without specific prior written permission.
*
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
* AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
* IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
* DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
* FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
* DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
* SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
* CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
* OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
* OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import Cocoa

class ConcreteTextStorage: NSTextStorage
{
	/// A storage facility for attributed text.
	fileprivate let storage = NSMutableAttributedString()

	/// Initializer.
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	/// Initializer.
	override init() {
		super.init()
	}

	/// Initializer.
	required init?(pasteboardPropertyList propertyList: Any, ofType type: String)
	{
		super.init(pasteboardPropertyList: propertyList, ofType: type)
	}
}

extension ConcreteTextStorage
{
	/// A String value of the attirbutedString property.
	override var string: String
	{
		return storage.string
	}

	/**
	Returns the attributes for the character at a given index.
	- Parameter location: An Int
	- Parameter effectiveRange range: Upon return, the range over which the
	attributes and values are the same as those at index. This range
	isn’t necessarily the maximum range covered, and its extent is
	implementation-dependent. If you need the maximum range, use
	attributesAtIndex:longestEffectiveRange:inRange:.
	If you don't need this value, pass NULL.
	- Returns: The attributes for the character at index.
	*/
	override func attributes(at location: Int, effectiveRange range: NSRangePointer?) -> [String: Any]
	{
		return storage.attributes(at: location, effectiveRange: range)
	}

	/**
	Replaces a range of text with a string value.
	- Parameter range: The character range to replace.
	- Parameter str: The string value that the characters
	will be replaced with.
	*/
	override func replaceCharacters(in range: NSRange, with str: String)
	{
		storage.replaceCharacters(in: range, with: str)
		edited(.editedCharacters, range: range, changeInLength: str.utf16.count - range.length)
	}

	/**
	Sets the attributedString attribute values.
	- Parameter attrs: The attributes to set.
	- Parameter range: A range of characters that will have their
	attributes updated.
	*/
	override func setAttributes(_ attrs: [String : Any]?, range: NSRange)
	{
		storage.setAttributes(attrs, range: range)
		edited(.editedAttributes, range: range, changeInLength: 0)
	}

	/**
	Adds an individual attribute.
	- Parameter _ name: Attribute name.
	- Parameter value: An Any type.
	- Parameter range: A range of characters that will have their
	attributes added.
	*/
	override func addAttribute(_ name: String, value: Any, range: NSRange)
	{
		storage.addAttribute(name, value: value, range: range)
		edited(.editedAttributes, range: range, changeInLength: 0)
	}

	/**
	Removes an individual attribute.
	- Parameter _ name: Attribute name.
	- Parameter range: A range of characters that will have their
	attributes removed.
	*/
	override func removeAttribute(_ name: String, range: NSRange)
	{
		storage.removeAttribute(name, range: range)
		edited(.editedAttributes, range: range, changeInLength: 0)
	}
}
