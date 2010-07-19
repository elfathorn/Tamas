function substract_attribute(num_tama, attribute)
{
    points = parseInt( $('#baby_tama_'+num_tama+'_leaving_points').html() );
    id = '#baby_tama_'+num_tama+'_'+attribute;
    old_value = parseInt($(id+'_span').html());
    new_value = old_value - 1;
    if( new_value >= 3 )
    {
        $(id+'_span').html(new_value);
        $(id).attr('value', new_value);
        $('#baby_tama_'+num_tama+'_leaving_points').html( points + 1 );
    }
    else
    {
        alert("can't be less than 3!");
    }
}

function add_attribute(num_tama, attribute)
{
    points = parseInt( $('#baby_tama_'+num_tama+'_leaving_points').html() );
    id = '#baby_tama_'+num_tama+'_'+attribute;
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
        $('#baby_tama_'+num_tama+'_leaving_points').html( points - 1 );
    }
}