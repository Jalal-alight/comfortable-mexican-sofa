require File.expand_path('../../test_helper', File.dirname(__FILE__))

class FieldStringTagTest < ActiveSupport::TestCase
  
  def test_initialize_tag
    assert tag = ComfortableMexicanSofa::Tag::FieldString.initialize_tag(
      cms_pages(:default), '{{ cms:field:content:string }}'
    )
    assert_equal 'content', tag.identifier
    assert tag = ComfortableMexicanSofa::Tag::FieldString.initialize_tag(
      cms_pages(:default), '{{cms:field:content:string}}'
    )
    assert_equal 'content', tag.identifier
    assert tag = ComfortableMexicanSofa::Tag::FieldString.initialize_tag(
      cms_pages(:default), '{{cms:field:content}}'
    )
    assert_equal 'content', tag.identifier
    assert tag = ComfortableMexicanSofa::Tag::FieldString.initialize_tag(
      cms_pages(:default), '{{cms:field:dash-content}}'
    )
    assert_equal 'dash-content', tag.identifier
  end
  
  def test_initialize_tag_failure
    [
      '{{cms:field:content:not_string}}',
      '{{cms:not_field:content}}',
      '{not_a_tag}'
    ].each do |tag_signature|
      assert_nil ComfortableMexicanSofa::Tag::FieldString.initialize_tag(
        cms_pages(:default), tag_signature
      )
    end
  end
  
  def test_content_and_render
    tag = ComfortableMexicanSofa::Tag::FieldString.initialize_tag(
      cms_pages(:default), '{{cms:field:content}}'
    )
    assert tag.block.content.blank?
    tag.block.content = 'test_content'
    assert_equal 'test_content', tag.content
    assert_equal '', tag.render
  end
  
end