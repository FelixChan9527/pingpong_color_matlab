function [point, mask] = PositionMorphology(point_up, point_down, mask)
    mask = bwmorph(mask,'open');  %ฟชิหหใ
end

