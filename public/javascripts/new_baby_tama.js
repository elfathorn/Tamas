function substract_attribute(attribute)
{
    points = parseInt( $('#baby_tama_leaving_points').html() );
    id = '#baby_tama_'+attribute;
    old_value = parseInt($(id+'_span').html());
    new_value = old_value - 1;
    if( new_value >= 3 )
    {
        $(id+'_span').html(new_value);
        $(id).attr('value', new_value);
        $('#baby_tama_leaving_points').html( points + 1 );
    }
    else
    {
        alert("can't be less than 3!");
    }
}

function add_attribute(attribute)
{
    points = parseInt( $('#baby_tama_leaving_points').html() );
    id = '#baby_tama_'+attribute;
    old_value = parseInt($(id+'_span').html());
    new_value = old_value + 1;
    if( points <= 0 )
    {
        alert("no points available!");
    }
    else
    {
        $(id+'_span').html(new_value);
        $(id).attr('value', new_value);
        $('#baby_tama_leaving_points').html( points - 1 );
    }
}