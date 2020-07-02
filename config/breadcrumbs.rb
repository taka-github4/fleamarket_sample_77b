crumb :root do
  link "トップページ", root_path
end

crumb :category_index do
  link "カテゴリー一覧", categories_path
end

crumb :parents do |category|
  category = Category.find(params[:id]).root
  link "#{category.name}", category_path(category)
  parent :category_index
end

crumb :children do |category|
  category = Category.find(params[:id])
  if category.has_children?
    link "#{category.name}", category_path(category)
    parent :parents
  else
    link "#{category.parent.name}", category_path(category.parent)
    parent :parents
  end
end

crumb :grandchildren do |category|
  category = Category.find(params[:id])
  link "#{category.name}", category_path(category)
  parent :children
end

crumb :itemparents do |category|
  @item = Item.find(params[:id])
  link "#{@item.category.parent.parent.name}", category_path(@item.category.parent.parent)
  parent :category_index
end

crumb :itemchildren do |category|
  @item = Item.find(params[:id])
  link "#{@item.category.parent.name}", category_path(@item.category.parent)
  parent :itemparents
end

crumb :itemgrandchildren do |category|
  @item = Item.find(params[:id])
  link "#{@item.category.name}", category_path(@item.category)
  parent :itemchildren
end